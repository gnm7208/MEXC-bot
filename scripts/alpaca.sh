#!/usr/bin/env bash
# Alpaca Markets API wrapper — paper and live.
# Usage: bash scripts/alpaca.sh <subcommand> [args...]
# Subcommands: account, positions, quote SYM, price SYM, bars SYM [tf] [n],
#              orders [SYM], order 'json', cancel OID, close SYM, close-all,
#              news SYM [n], snapshot SYM [SYM ...], movers
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT/.env"
if [[ -f "$ENV_FILE" ]]; then
  set -a; source "$ENV_FILE"; set +a
fi

KEY="${ALPACA_API_KEY_ID:?ALPACA_API_KEY_ID not set in environment}"
SECRET="${ALPACA_API_SECRET_KEY:?ALPACA_API_SECRET_KEY not set in environment}"
BASE="${ALPACA_BASE_URL:-https://paper-api.alpaca.markets}"
DATA="${ALPACA_DATA_URL:-https://data.alpaca.markets}"

H=(-H "APCA-API-KEY-ID: $KEY" -H "APCA-API-SECRET-KEY: $SECRET")

cmd="${1:-}"; shift || true

case "$cmd" in

  account)
    curl -fsS "${H[@]}" "$BASE/v2/account" | python3 -c "
import json, sys
a = json.load(sys.stdin)
print('equity:', a['equity'])
print('cash:', a['cash'])
print('buying_power:', a['buying_power'])
print('portfolio_value:', a['portfolio_value'])
"
    ;;

  positions)
    curl -fsS "${H[@]}" "$BASE/v2/positions" | python3 -c "
import json, sys
ps = json.load(sys.stdin)
if not ps: print('No open positions'); exit()
for p in ps:
    pnl_pct = float(p.get('unrealized_plpc','0')) * 100
    print(p['symbol'], '| qty:', p['qty'],
          '| entry: \$'+p['avg_entry_price'],
          '| current: \$'+p.get('current_price','?'),
          f'| P&L: {pnl_pct:+.2f}%')
"
    ;;

  quote)
    sym="${1:?quote requires SYMBOL}"
    curl -fsS "${H[@]}" "$DATA/v2/stocks/$sym/quotes/latest?feed=iex" | python3 -c "
import json, sys
q = json.load(sys.stdin).get('quote', {})
bp = float(q.get('bp', 0)); ap = float(q.get('ap', 0))
spread_pct = (ap - bp) / bp * 100 if bp > 0 else 0
print(f'bid: \${bp:.4f} | ask: \${ap:.4f} | spread: {spread_pct:.3f}%')
"
    ;;

  price)
    sym="${1:?price requires SYMBOL}"
    curl -fsS "${H[@]}" "$DATA/v2/stocks/$sym/bars/latest?feed=iex" | \
      python3 -c "import json,sys; b=json.load(sys.stdin)['bar']; print(b['c'])"
    ;;

  bars)
    sym="${1:?bars requires SYMBOL}"
    tf="${2:-1Day}"; limit="${3:-30}"
    curl -fsS "${H[@]}" "$DATA/v2/stocks/$sym/bars?timeframe=$tf&limit=$limit&feed=iex"
    ;;

  orders)
    sym="${1:-}"
    url="$BASE/v2/orders?status=open&limit=50"
    [[ -n "$sym" ]] && url="$url&symbols=$sym"
    curl -fsS "${H[@]}" "$url" | python3 -c "
import json, sys
orders = json.load(sys.stdin)
if not orders: print('No open orders'); exit()
for o in orders:
    print(o['id'], '|', o['symbol'], o['side'], o['qty'],
          o.get('order_type','?'), 'stop:', o.get('stop_price','—'))
"
    ;;

  order)
    payload="${1:?order requires JSON payload}"
    curl -fsS "${H[@]}" -X POST "$BASE/v2/orders" \
      -H "Content-Type: application/json" -d "$payload"
    ;;

  cancel)
    oid="${1:?cancel requires ORDER_ID}"
    curl -fsS "${H[@]}" -X DELETE "$BASE/v2/orders/$oid"
    echo "Cancelled $oid"
    ;;

  cancel-all)
    sym="${1:-}"
    if [[ -n "$sym" ]]; then
      ids=$(curl -fsS "${H[@]}" "$BASE/v2/orders?status=open&symbols=$sym" \
        | python3 -c "import json,sys; [print(o['id']) for o in json.load(sys.stdin)]")
      while IFS= read -r oid; do
        curl -fsS "${H[@]}" -X DELETE "$BASE/v2/orders/$oid" >/dev/null
        echo "Cancelled $oid"
      done <<< "$ids"
    else
      curl -fsS "${H[@]}" -X DELETE "$BASE/v2/orders"
      echo "All open orders cancelled"
    fi
    ;;

  close)
    sym="${1:?close requires SYMBOL}"
    curl -fsS "${H[@]}" -X DELETE "$BASE/v2/positions/$sym" | python3 -c "
import json, sys
o = json.load(sys.stdin)
print('Closed', o.get('symbol','?'), '| filled qty:', o.get('filled_qty','?'),
      '| avg price:', o.get('filled_avg_price','?'))
"
    ;;

  close-all)
    curl -fsS "${H[@]}" -X DELETE "$BASE/v2/positions?cancel_orders=true" | python3 -c "
import json, sys
rs = json.load(sys.stdin)
if isinstance(rs, list): print(f'Submitted closes for {len(rs)} positions')
else: print(rs)
"
    ;;

  news)
    sym="${1:?news requires SYMBOL}"
    limit="${2:-5}"
    curl -fsS "${H[@]}" "$DATA/v1beta1/news?symbols=$sym&limit=$limit" | python3 -c "
import json, sys
for n in json.load(sys.stdin).get('news', []):
    print(n['created_at'][:16], '|', n['headline'])
    if n.get('summary'):
        print('   ', n['summary'][:150])
"
    ;;

  snapshot)
    syms="${*:?snapshot requires SYMBOL [SYMBOL ...]}"
    syms_csv="${syms// /,}"
    curl -fsS "${H[@]}" "$DATA/v2/stocks/snapshots?symbols=$syms_csv&feed=iex" | python3 -c "
import json, sys
snaps = json.load(sys.stdin)
for sym, s in sorted(snaps.items(), key=lambda x: -float(x[1].get('dailyBar',{}).get('vw',0))):
    db = s.get('dailyBar', {}); pb = s.get('prevDailyBar', {})
    if db and pb and float(pb.get('c',0)) > 0:
        chg = (float(db['c']) - float(pb['c'])) / float(pb['c']) * 100
        vol = float(db.get('v', 0))
        print(f'{sym}: {chg:+.2f}% | vol: {vol:,.0f} | price: \${float(db[\"c\"]):.2f}')
"
    ;;

  movers)
    # Top intraday movers from a liquid universe (S&P 100 + NASDAQ 100 heavy hitters)
    UNIVERSE="AAPL,MSFT,NVDA,AMZN,GOOGL,META,TSLA,AVGO,JPM,LLY,UNH,XOM,V,MA,HD,PG,JNJ,ABBV,MRK,BAC,WMT,CRM,CVX,KO,PEP,COST,ADBE,TMO,ACN,MCD,ABT,NKE,NFLX,AMD,QCOM,TXN,PM,DHR,NEE,ORCL,UNP,MS,GS,CAT,SBUX,ISRG,NOW,INTU,AMAT,ADI,LRCX,PANW,KLAC,CDNS,SNPS,MRVL,GILD,REGN,VRTX,AXP,BLK,SCHW,ADP,SYK,MDLZ,DE,TGT,LOW,ELV,CI,MMC,PLD,AMT,CCI,EQIX,DLR,SPG,O,WELL,PSA"
    curl -fsS "${H[@]}" "$DATA/v2/stocks/snapshots?symbols=$UNIVERSE&feed=iex" | python3 -c "
import json, sys
snaps = json.load(sys.stdin)
results = []
for sym, s in snaps.items():
    db = s.get('dailyBar', {}); pb = s.get('prevDailyBar', {})
    if db and pb and float(pb.get('c',0)) > 0:
        chg = (float(db.get('c',0)) - float(pb['c'])) / float(pb['c']) * 100
        vol = float(db.get('v', 0))
        results.append((sym, chg, vol, float(db.get('c',0))))
results.sort(key=lambda x: -x[1])
print('--- TOP GAINERS ---')
for sym, chg, vol, price in results[:10]:
    print(f'{sym}: {chg:+.2f}% | vol: {vol:,.0f} | \${price:.2f}')
print('--- TOP LOSERS ---')
for sym, chg, vol, price in results[-5:]:
    print(f'{sym}: {chg:+.2f}% | vol: {vol:,.0f} | \${price:.2f}')
"
    ;;

  *)
    echo "Usage: bash scripts/alpaca.sh <account|positions|quote SYM|price SYM|bars SYM [tf] [n]|orders [SYM]|order 'json'|cancel OID|cancel-all [SYM]|close SYM|close-all|news SYM [n]|snapshot SYM...|movers>" >&2
    exit 1
    ;;
esac
echo
