# Alpaca Stock Bot — Research Log

## 2026-08-19 — Alpaca Morning Research

### BLOCKED — Missing Credentials

`ALPACA_API_KEY_ID` and `ALPACA_API_SECRET_KEY` not set in environment.
`scripts/alpaca.sh account` failed: `ALPACA_API_KEY_ID not set in environment`.

Cannot fetch account, positions, movers, quotes, or bars. Research skipped
in full — no candidates scanned, no trades evaluated.

CLICKUP_API_KEY and PERPLEXITY_API_KEY were present and working; issue is
isolated to Alpaca credentials on this cloud routine.

Notified via ClickUp. Needs env var fix on the cloud runner config before
the next scheduled run (morning-execution, midday, eod-scan will also fail).

### Decision
CIRCUIT_BREAKER (credentials unavailable, not a trading halt)

### Addendum — 2026-08-19 09:45 ET (morning-execution)
Alpaca credentials ARE set and working on this run (`account` call succeeded:
equity $100,000, cash $100,000, no open positions/orders). Issue was isolated
to the earlier morning-research run's environment. Per CIRCUIT_BREAKER
protocol, no Trade Ideas exist for today (research was skipped), so
morning-execution ran STEP 2 monitor-only (nothing to monitor — zero open
positions) and took no trades. Next morning-research run should re-verify
credentials by execution before assuming they're still missing.

### EOD Scan — 2026-08-19
Open positions held overnight: none
Positions cut: none
Tomorrow's watchlist: WMT (earnings before open, confirmed — largest grocer/
private employer per CNBC preview); TGT/LOW/TJX/ADI/EL were TODAY's (8/19)
earnings, not tomorrow's — Perplexity query returned mostly same-day results,
low confidence on other names for 8/20. No FDA/upgrade/acquisition catalysts
surfaced.
Account equity EOD: $100,000.00

## 2026-08-20 — Alpaca Morning Research

### Market Context
Sentiment: NEUTRAL
Futures: S&P +0.1-0.5% (pre-market, modest) | SPY live +0.22% | QQQ live -0.24%
Risk events today: FOMC Minutes (afternoon), Initial Jobless Claims 209K vs 210K exp (in-line),
Philly Fed Mfg Index big miss (24.1 vs 41.4 est). Iran "Operation Economic Fury" headline caused
brief futures risk-off spike premarket but live SPY tape shows only mild +0.22% — largely priced
out by open. No CPI/NFP today. Net: mixed/no clear direction, standard threshold (score >= 6).

### Movers Scanned
MRK +12.59% (vol 1.35M), MRVL +9.87% (987K), NOW +6.44% (1.22M), DHR +6.05% (371K),
ACN +6.05% (309K), CRM +5.16% (549K), VRTX +4.48% (80K), LLY +4.39% (232K), TGT +4.36% (584K),
TSLA +4.24% (1.02M) | Losers: AMD/PANW/KLAC/AVGO/LRCX (chip pullback, not candidates)

### Signal Table
| Ticker | Chg% | Vol× | RSI | SMA50 | Catalyst | Cat pts | Score | ATR stop | ATR tgt | R:R | Eligible? |
|--------|------|------|-----|-------|----------|---------|-------|----------|---------|-----|-----------|
| TGT  | +4.36% | 3.0x | 60 | above | EARNINGS_BEAT (Q2 beat, FY guide raised 8/19) | +3 | 7/15 | 4.0% | 8.0% | 2.00 | YES |
| MRK  | +12.59% | 4.5x | 82 | above | ANALYST_UPGRADE (1 firm turns bullish) | +2 | 6/15 | 4.0% | 8.0% | 2.00 | Marginal — see note |
| MRVL | +9.87% | 1.8x | 53 | above | NO_CATALYST (conflicting premkt headline, earnings not until 8/27) | 0 | 5/15 | 5.5% | 11.0% | 2.00 | NO |
| NOW  | +6.44% | 1.2x | 59 | above | NO_CATALYST (bearish analyst commentary, Tiger Global -42% stake) | 0 | 3/15 | 4.2% | 8.3% | 2.00 | NO |
| ACN  | +6.05% | 0.9x | 62 | above | NO_CATALYST (WF maintains but lowers PT) | 0 | 3/15 | 4.0% | 8.0% | 2.00 | NO |
| DHR  | +6.05% | 1.1x | 72 | above | NO_CATALYST (13F stake disclosure only) | 0 | 2/15 | 4.0% | 8.0% | 2.00 | NO |
| CRM  | +5.16% | 1.2x | 66 | above | ANALYST_UPGRADE (mixed: 1 reiterate OW, 1 raise PT to below current) | +2 | 4/15 | 4.0% | 8.0% | 2.00 | NO |
| LLY  | +4.39% | 2.2x | 72 | above | NO_CATALYST | 0 | 3/15 | 4.0% | 8.0% | 2.00 | NO |
| VRTX | +4.48% | 1.3x | 80 | above | NO_CATALYST | 0 | 0/15 | 4.0% | 8.0% | 2.00 | NO |
| TSLA | +4.24% | 1.0x | 69 | BELOW | NO_CATALYST (fund cut stake 78%) | 0 | 0/15 | 4.0% | 8.0% | 2.00 | NO (below SMA50) |

### Trade Ideas
1. TGT — Score: 7/15 | Notional: $400 | Entry ~$159.14 | Stop ~$152.78 (-4.0% ATR) | Target ~$171.87 (+8.0% ATR)
   Catalyst: Q2 EPS $2.46 vs $2.25 est, revenue $26.5B vs $26.1B est, FY guidance raised (net sales
   growth to ~5%, EPS to $9.90-10.90 incl. tariff refund benefit). Reported 8/19, still reacting 8/20.
   RSI 60 (sweet spot, not overbought), above SMA50, only -3.2% below prev-day high (not chasing).
   Sector: Consumer (Retail)

   NOTE — MRK not taken despite scoring 6/15 (marginal pass): RSI 82 is deeply overbought, stock
   gapped +12.59% and is already >10% above prev-day high (extreme extension = chase risk). News
   feed also mixed MRNA (Moderna) headlines in with genuine MRK catalyst, muddying the signal.
   Skipping per discretion — one clean high-quality setup (TGT) preferred over a stretched chase.

### SECTOR_BLOCKED
none

### Decision
TRADE: TGT $400 notional (pending morning-execution at 9:45 AM ET for entry + stop/TP order placement)

### Addendum — 2026-08-20 09:45 ET (morning-execution)
Account: equity $100,000, cash $100,000, 0 open positions, 0 open orders — nothing to
monitor. Daily/weekly gates clear (0 trades today, 0 open positions).

TGT re-validation:
- Price: $159.02 (RESEARCH-LOG entry ~$159.14) — flat, momentum intact, no reversal/chase.
- Spread gate: bid $151.24 / ask $159.49 → 5.455% (re-checked 3x, stable, not a transient
  glitch). Max allowed is 0.3%. **SKIP — liquidity risk gate failed.**

No trade executed today. Note: IEX-feed-only quotes can show inflated spreads vs true
consolidated NBBO for large-caps like TGT, but the rulebook gate is on the IEX quote as
returned by `scripts/alpaca.sh quote` with no discretion carve-out — followed as written
rather than overridden on a data-quality guess. Flagging for review: if this recurs on
liquid large-caps, worth checking whether the data feed/quote endpoint needs adjustment.
