# Alpaca Stock Bot — Trading Strategy (Paper Trading)

## Mission
Learn US stock momentum trading on paper capital before committing real money.
Long-only spot stocks. No options, no margin, no shorting, ever.

## Capital & Constraints
- Platform: Alpaca Paper Trading
- Virtual capital reference: $10,000 (standard paper account)
- Position size: 5% of virtual = $500/bet (up to 8 positions)
- Target deployment: 70-80% (hold 20-30% cash as dry powder)
- Market hours only: 9:45 AM–3:30 PM ET, Monday–Friday

## Signal Scoring (Layer 2) — max ~15 pts

| Signal | Points |
|--------|--------|
| Intraday price change ≥ +3% | +2 |
| Intraday price change ≥ +5% (bonus) | +1 |
| Volume ≥ 1.5× 20-day average | +2 |
| Volume ≥ 3× 20-day average (bonus) | +1 |
| Catalyst: earnings beat (last 24h) | +3 |
| Catalyst: analyst upgrade (last 24h) | +2 |
| Catalyst: acquisition / FDA / listing news | +2 |
| RSI(14) in 40-65 range (recovering, not overbought) | +1 |
| Price above 50-day SMA (uptrend) | +1 |
| Sector ETF also up >1% today | +1 |
| Price within 2% of prev-day high (near resistance) | -2 |
| RSI(14) > 75 (chasing overbought) | -1 |

Entry eligibility: SCORE >= 6 to enter. SCORE >= 9 = high conviction.

## Position Sizing

VIRTUAL_CAPITAL = 10000.0
- Score 6-8:  BASE_PCT = 4% → $400/bet
- Score 9-11: BASE_PCT = 5% → $500/bet
- Score >= 12: BASE_PCT = 6% → $600/bet

FINAL_NOTIONAL = min(VIRTUAL_CAPITAL * BASE_PCT, available_cash * 0.90)
Minimum: $1 (Alpaca minimum notional)

## ATR-Based Stops and Targets

At entry, compute 14-day ATR from daily bars:
```python
bars = fetch(f'/v2/stocks/{SYM}/bars?timeframe=1Day&limit=15&feed=iex')
ranges = [float(b['h']) - float(b['l']) for b in bars['bars'][:-1]]
daily_atr = sum(ranges) / len(ranges)
atr_pct = daily_atr / fill_price * 100

stop_pct   = max(4.0, min(8.0, atr_pct * 1.0))   # 1x ATR, clamped 4-8%
target_pct = max(8.0, min(15.0, atr_pct * 2.0))  # 2x ATR, clamped 8-15%
```

R:R minimum: 1.5:1 (target_pct / stop_pct >= 1.5). Skip if not met.

Place REAL orders on Alpaca immediately after fill:
- Stop-loss: `type=stop, stop_price=fill*(1-stop_pct/100), time_in_force=gtc`
- Take-profit: `type=limit, limit_price=fill*(1+target_pct/100), time_in_force=gtc`

Record both order IDs in TRADE-LOG so they can be updated or cancelled.

## Core Rules

1. LONG-ONLY — no shorts, no options, no margin, ever
2. Market hours only: no pre-market or after-hours entries
3. Wait 15 minutes after open before entering (9:45 AM ET minimum)
4. Every position gets a stop ORDER and a take-profit ORDER immediately after fill
5. ATR-based stop (4-8%), ATR-based target (8-15%). R:R >= 1.5 required.
6. Max 8 open positions; max $600 per position
7. Max 20 new trades per week; max 5 trades per day
8. Weekly circuit breaker: if >= 40% of closed trades this week are losses (min 5 trades)
   → halt; resume Monday or when market conditions improve
9. Daily gate: if >= 5 trades today AND win rate < 50% → halt until tomorrow
10. Cut thesis-broken positions immediately (bad earnings, sector collapse)
11. Sector tracking: note sector (Tech/Finance/Health/Energy/Consumer) in every entry
    - SECTOR_BLOCKED: 2+ consecutive losses in same sector → avoid that sector

## Buy-Side Gate (all must pass)

- Market is open (9:45 AM–3:30 PM ET)
- SCORE >= 6 (or high-conviction catalyst regardless of score)
- ATR R:R >= 1.5
- Total positions after fill <= 8
- Trades today <= 5; trades this week <= 20
- Weekly circuit breaker NOT active; daily gate NOT active
- Ticker NOT in SECTOR_BLOCKED sector
- Price above 50-day SMA (no downtrend entries)
- Not already holding this ticker

## TRADE-LOG Entry Format

## YYYY-MM-DD — Trade Entry
**BUY** SYMBOL | Qty: X.XX | Entry: $X.XX | Stop: $X.XX (-X.X% ATR) | Target: $X.XX (+X.X% ATR)
**ATR:** $X.XX (X.X% of price) | **Score:** X/15 | **Notional:** $X
**Stop Order ID:** alpaca-order-id-here
**TP Order ID:** alpaca-order-id-here
**Thesis:** ...
**Catalyst:** ...
**Sector:** Tech / Finance / Health / Energy / Consumer

## Exit Format

## YYYY-MM-DD — Trade Exit
**SELL** SYMBOL | Exit: $X.XX | Realized P&L: +/-$X (+/-X%) | Reason: stop hit / TP hit / thesis broken
(Cancel remaining open stop/TP orders after any manual close)
