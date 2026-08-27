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

### Addendum — 2026-08-20 12:30 ET (midday)
Positions: 0 | Open orders: 0 | Equity $100,000 (all cash). Nothing to monitor —
no stops/TPs to verify, no thesis checks, no trailing tightens. No-op run.

Spread-gate follow-up (flagged at 09:45): not a systemic feed problem. Live IEX
quotes — SPY 0.004%, AAPL 0.013% (both tight), TGT 3.029% (still wide). The wide
print is TGT-specific thin IEX book depth, not a broken quote endpoint. Gate is
behaving correctly; no config change warranted.

### EOD Scan — 2026-08-20
Open positions held overnight: none
Positions cut: none
Tomorrow's watchlist: BJ (BJ's Wholesale Club, pre-market earnings, EPS est $1.17
vs $1.14 LY, confirmed); UI (Ubiquiti, pre-market earnings, EPS est ~$4.03-4.15);
BKE (Buckle, pre-market earnings, EPS est $0.81). No upgrade/acquisition/FDA
catalysts surfaced — earnings-only calendar for 8/21.
Account equity EOD: $100,000.00

## 2026-08-21 — Alpaca Morning Research

### Market Context
Sentiment: NEUTRAL
Futures: S&P +0.1-0.3% | Nasdaq +0.2-0.6% (mild rebound after Thursday's sharp
selloff; still fragile — elevated bond yields, Middle East tensions weighing).
Risk events today: S&P Global Flash Mfg/Services PMI 9:45 AM ET, FOMC Minutes
(July meeting) 2:00 PM ET. No CPI/NFP. Standard threshold (score >= 6).
Note: WMT -9.23% today (worst session in 4 years) after Q2 miss/guide cut —
not a candidate (long-only, no shorts).

### Movers Scanned
Gainers: DE +6.90% (221,977 vol), MRVL +5.79% (722,246), TMO +2.26%, NOW +2.02%,
DHR +2.00%, LRCX +1.12%, DLR +1.04%, PM +0.90%, CCI +0.89%, XOM +0.87%
Losers: WMT -9.23%, ISRG -5.89%, SYK -3.61%, MS -3.21%, PANW -2.88%

### Signal Table
| Ticker | Chg% | Vol× | RSI | SMA50 | Catalyst | Cat pts | Score | ATR stop | ATR tgt | R:R | Eligible? |
|--------|------|------|-----|-------|----------|---------|-------|----------|---------|-----|-----------|
| DE   | +6.90% | 4.0x | 60 | above | EARNINGS_BEAT (Q3 EPS $5.10 vs est, revenue beat, FY guide raised) | +3 | 9/15 | 4.0% | 8.0% | 2.00 | YES — high conviction |
| MRVL | +5.79% | 1.2x | 66 | above | ANALYST_UPGRADE (Oppenheimer PT $300, BMO initiates Outperform $250, on Google AI-chip deal) | +2 | 4/15 | 5.4% | 10.9% | 2.00 | NO — vol <1.5x, below score threshold |

### Trade Ideas
1. DE — Score: 9/15 | Notional: $500 | Entry ~$620.72 | Stop ~$595.89 (-4.0% ATR) | Target ~$670.38 (+8.0% ATR)
   Catalyst: Q3 FY26 EPS $5.10 beat, revenue $12.61B beat, FY26 net income guide raised
   to $4.75-5.0B low end. Construction/forestry strength offsetting ag weakness;
   management flagged 2026 as possible ag-cycle trough. Still reacting day after report.
   RSI 60 (sweet spot), above SMA50, -4.3% below prev-day high (not chasing), vol 4.0x avg.
   Sector: Industrials (Ag/Construction Equipment)

   NOTE — MRVL not taken: only 1.2x volume (needs 1.5x for points), RSI 66 slightly
   outside 40-65 sweet spot. Catalyst real (Google AI silicon deal, $12.2B warrant,
   multiple analyst PT raises) but earnings not until 8/27 — elevated gap risk into
   a stop/TP window with no fresh volume confirmation. FINAL_SCORE 4/15 < 6 minimum.

### SECTOR_BLOCKED
none

### Decision
TRADE: DE $500 notional (pending morning-execution at 9:45 AM ET for entry + stop/TP order placement)

### Addendum — 2026-08-21 09:45 ET (morning-execution)
Account: equity $100,000, cash $100,000, 0 open positions, 0 open orders — nothing to
monitor. Daily/weekly gates clear (0 trades today, 0 open positions).

DE re-validation:
- Price: $622.92 (RESEARCH-LOG entry ~$620.72) — +0.35%, momentum intact, no reversal/chase.
- Spread gate: bid $591.23 / ask $644.67 → 9.039% (re-checked 3x, stable). Max allowed is
  0.3%. **SKIP — liquidity risk gate failed.**

Same IEX-thin-book pattern as TGT on 8/20 (see that day's addenda) — followed the rulebook
as written, no discretion carve-out. No trade executed today.

### EOD Scan — 2026-08-21
Open positions held overnight: none (0 open positions, 0 open orders all day —
DE skipped at morning-execution on liquidity/spread gate, no other trade taken)
Positions cut: none
Tomorrow's watchlist: none confirmed — next trading day is Monday 2026-08-24 (today
is Friday). Perplexity earnings-catalyst query returned only today's (8/21) pre-market
reporters (UI, BJ, BEKE), already stale by close; no Monday pre-market catalyst names
surfaced. Movers scan: gainers led by TSLA +5.80%, DE +4.96%, GS +3.84%; losers MRVL
-5.42%, PM -1.69% — no fresh catalyst-confirmed setups from this list, re-screen at
Monday morning-research.
Account equity EOD: $100,000.00

### EOD Scan — 2026-08-24
Open positions held overnight: none (0 open positions, 0 open orders — nothing to
cut, no stop/TP checks needed)
Positions cut: none
Movers scan: gainers led by MA +3.14%, V +3.05%, COST +2.51%, WMT +2.50%, TGT +2.36%;
losers AMD -3.51%, TSLA -3.34%, MRVL -3.10%, NVDA -2.69%, ORCL -2.37% — no fresh
catalyst-confirmed setups from this list.
Tomorrow's watchlist: DKS (pre-market earnings, EPS est. $3.75-3.77) and GFI (pre-market
earnings, EPS est. $2.69) are the confirmed pre-market reporters for 2026-08-25; HEI,
SMTC, NCNO also report but timing less certain. INTU and ZM report but postmarket, not
pre-market. No non-earnings (upgrade/acquisition/FDA) catalysts surfaced. Re-screen at
Tuesday morning-research for volume/RSI/spread confirmation before any entry.
Account equity EOD: $100,000.00

## 2026-08-25 — Alpaca Morning Research

### Market Context
Sentiment: NEUTRAL
Futures: S&P +0.1-0.4% | Nasdaq +0.5% (mild risk-on tilt, not a clean signal — one
source flags recent single-name/sector volatility arguing against calling it clean
risk-on). Standard threshold (score >= 6).
Risk events today: no FOMC, no CPI. Fed Barkin speech, ADP weekly employment, Case-Shiller
home price index, Richmond Fed mfg index, Consumer Confidence, New Home Sales, 2Y/5Y note
auctions — moderate data day, no single high-impact catalyst.

### Movers Scanned
Gainers: MA +3.31% (173,051 vol), V +3.03% (309,080), WMT +2.72% (1,011,052), TGT +2.67%
(364,449), COST +2.57% (77,817), UNH +2.24%, META +1.72%, PM +1.67%, AMT +1.50%, JPM +1.37%
Losers: TSLA -3.81%, AMD -3.45%, MRVL -3.26%, NVDA -2.92%, ORCL -2.74%
Note: this is yesterday's (8/24) EOD change carried into the pre-open snapshot — market
hasn't opened yet at 9:00 AM ET. Only MA and V clear the +3% flag threshold.

### Signal Table
| Ticker | Chg% | Vol× | RSI | SMA50 | Catalyst | Cat pts | Score | ATR stop | ATR tgt | R:R | Eligible? |
|--------|------|------|-----|-------|----------|---------|-------|----------|---------|-----|-----------|
| MA | +3.31% | 1.04x | 76 | above | none confirmed in last 24h (stale Trump-buy disclosure from 8/24 + Jul 30 earnings beat, not fresh) | 0 | 0/15 | 4.0% | 8.0% | 2.00 | NO — vol <1.5x, RSI 76 overbought (-1), within 2% of prev-day high (-2), score 0 < 6 |
| V  | +3.03% | 1.08x | 77 | above | none confirmed in last 24h (same Trump-buy disclosure + old earnings beat) | 0 | 0/15 | 4.0% | 8.0% | 2.00 | NO — vol <1.5x, RSI 77 overbought (-1), within 2% of prev-day high (-2), score 0 < 6 |

### Trade Ideas
None — both flagged movers score 0/15, well below the 6-point minimum. No fresh
(last-24h) catalyst on either name; move looks like late-stage chase (RSI 76-77,
volume below 1.5x average, price near prior-day high).

Watchlist carried from 8/24 EOD scan (DKS, GFI pre-market earnings reporters today) is
outside the alpaca.sh movers universe (large-cap S&P100/Nasdaq100 list) — not scored
this cycle; would need manual bars/quote pull if flagged as a candidate at midday.

### SECTOR_BLOCKED
none

### Decision
HOLD — no rules-clean entries. 0 open positions, 0 open orders, daily/weekly gates
clear (0 trades today). Re-screen at morning-execution (9:45 AM ET) and midday.
Account equity: $100,000.00

### Addendum — 2026-08-25 09:45 ET (morning-execution)
Decision = HOLD → monitor only per routine. Account: equity $100,000, cash $100,000,
buying power $400,000. 0 open positions, 0 open orders — nothing to check (no
thesis/stop/TP review needed). No trade executed.

### EOD Scan — 2026-08-25
Open positions held overnight: none (0 open positions, 0 open orders all day —
morning-research/execution both HOLD, no rules-clean entries surfaced)
Positions cut: none
Movers scan (3:30 PM ET): gainers AMD +5.03%, CDNS +4.60%, MRVL +4.17%, MRK +3.61%,
SNPS +3.25%; losers TGT -4.12%, NKE -3.14%, INTU -3.02%, PANW -3.01%, DE -2.69% — no
fresh catalyst-confirmed setups from this list (all late-session moves, no new
catalyst check run this cycle).
Tomorrow's watchlist: confirmed pre-market (before-open) earnings reporters for
2026-08-26 — ANF (Abercrombie & Fitch, EPS est $1.99), KSS (Kohl's, EPS est $0.58),
WSM (Williams-Sonoma). Also reporting pre-market: BBWI, DCI, DY, SJM. Note: NVDA, CRM,
CRWD, A (Agilent) report after-close 8/26 — these move the 8/27 open, not tomorrow's,
but flag for Thursday morning-research. No acquisition/FDA catalysts surfaced.
Account equity EOD: $100,000.00

## 2026-08-26 — Alpaca Morning Research

### Market Context
Sentiment: NEUTRAL
Futures: S&P +0.1-0.3% | Nasdaq +0.5-0.6% (mixed-to-mild-risk-on; some feeds call the
open "mixed", others "modestly constructive" — not a clean bullish signal).
Standard threshold (score >= 6).
Risk events today: no FOMC rate decision, no CPI. PCE price index + Q2 GDP second
estimate + personal income/spending at 8:30 AM ET (Fed's preferred inflation gauge —
moderate-impact, releases before open so priced in by 9:45 AM entry window); FOMC
Minutes at 1:00 PM (not a policy decision). NVDA reported after-close 8/25: reaction
roughly flat (+0.26% after-hours vs $213.05 close, implied move ~5.4% priced in but
didn't materialize) — no outsized AI-chip sector reaction to trade off today.

### Movers Scanned
Gainers: CDNS +5.05% (192,189 vol), AMD +4.86% (612,564), MRVL +4.82% (539,947),
MRK +3.81% (617,216), SNPS +3.62% (66,257), NFLX +2.80%, NVDA +2.15%, GS +2.15%,
DLR +2.01%, META +1.96%
Losers: DE -2.73%, PANW -3.07%, NKE -3.15%, INTU -3.44%, TGT -3.82%
Note: pre-open snapshot reflects 8/25 EOD daily-bar change (market not open yet at
9:00 AM ET) — same names/magnitudes as yesterday's 3:30 PM EOD scan. Five names clear
the +3% flag threshold: CDNS, AMD, MRVL, MRK, SNPS.
Not in movers universe (S&P100/Nasdaq100 large-cap list): today's confirmed pre-market
earnings reporters ANF, KSS, WSM, BBWI, DCI, DY, SJM carried from 8/25 EOD watchlist —
not scored this cycle.

### Signal Table
| Ticker | Chg% | Vol× | RSI | SMA50 | Catalyst | Cat pts | Score | ATR stop | ATR tgt | R:R | Eligible? |
|--------|------|------|-----|-------|----------|---------|-------|----------|---------|-----|-----------|
| CDNS | +5.05% | 1.61x | 75 | BELOW | none confirmed in last 24h (stale 7/28 B of A PT raise to $420) | 0 | 3/15 | 4.0% | 8.0% | 2.00 | NO — below 50-day SMA (hard skip), score 3 < 6 |
| AMD | +4.86% | 0.96x | 59 | BELOW | ANALYST_UPGRADE — Raymond James Strong Buy, PT $565→$641 (8/25, within 24h) | +2 | 3/15 | 4.0% | 8.0% | 2.00 | NO — below 50-day SMA (hard skip), vol <1.5x, score 3 < 6 |
| MRVL | +4.82% | 0.93x | 54 | above | NO_CATALYST — pre-earnings run-up only, Q2 reports 8/27 (not yet reported, not a confirmed beat) | 0 | 2/15 | 5.7% | 11.4% | 2.00 | NO — vol <1.5x, no catalyst, score 2 < 6 |
| MRK | +3.81% | 1.48x | 71 | above | FDA/clinical + ANALYST_UPGRADE — Phase 3 melanoma trial (Keytruda + Moderna) met endpoints; Morgan Stanley upgrade to Overweight, PT $179 (8/25, within 24h) | +4 | 5/15 | 4.0% | 8.0% | 2.00 | NO — score 5 < 6 (near-miss); RSI 71 not in sweet spot, price already through prev-day high (-2 proximity penalty) |
| SNPS | +3.62% | 0.94x | 67 | BELOW | NO_CATALYST — Q3 earnings today after-close, pre-report speculation only ("Buy reiterated" ahead of print, not a beat) | 0 | 0/15 | 4.0% | 8.0% | 2.00 | NO — below 50-day SMA (hard skip), vol <1.5x, score 0 < 6 |

### Trade Ideas
None — all five flagged movers fail the gate. CDNS/AMD/SNPS are below their 50-day
SMA (hard skip regardless of score or catalyst). MRVL has no confirmed catalyst
(earnings not until 8/27) and scores only 2/15. MRK is the closest call — real
clinical + analyst catalysts (+4 pts) but still lands at 5/15, one point under the
6-point minimum, and is already trading through its prior-day high (chasing, not a
clean breakout entry) with volume under 1.5x average. No override — Rule 12 core-BTC
equivalent doesn't apply to alpaca (no index-hold rule for stocks); staying flat.

### SECTOR_BLOCKED
none

### Decision
HOLD — no rules-clean entries. 0 open positions, 0 open orders, daily/weekly gates
clear (0 trades this week). Re-screen at morning-execution (9:45 AM ET) and midday —
MRK is worth a fresh RSI/volume check post-open given it's only 1 point off threshold
and has the strongest genuine catalyst of the group.
Account equity: $100,000.00

### Addendum — 2026-08-26 09:45 ET (morning-execution)
Decision = HOLD → monitor only per routine. Account: equity $100,000, cash $100,000,
buying power $400,000. 0 open positions, 0 open orders — nothing to check (no
thesis/stop/TP review needed). No trade executed.

### EOD Scan — 2026-08-27
Note: no morning-research/morning-execution/midday entries found for 2026-08-27 in
this log (no commits today prior to this scan) — those routines appear not to have
run or logged. Flagging for review; proceeding with EOD scan on live account state.
Open positions held overnight: none (0 open positions, 0 open orders — nothing to
cut, no stop/TP checks needed)
Positions cut: none
Movers scan (3:30 PM ET): gainers ORCL +2.84%, SBUX +2.55%, QCOM +1.97%, MRVL +1.97%,
CAT +1.28%, AAPL +1.16%, UNH +1.12%, META +1.10%, MSFT +0.98%, TMO +0.94%; losers
LLY -3.57%, INTU -3.20%, ACN -3.05%, SCHW -2.57%, REGN -2.28% — no fresh
catalyst-confirmed setups scored this cycle (0 positions to manage, screen deferred
to tomorrow's morning-research).
Tomorrow's watchlist: confirmed pre-market (before-open) earnings reporters for
2026-08-28 (all small/mid-cap, outside the S&P100/Nasdaq100 movers universe) — MNSO
(MINISO Group, EPS est $0.28-0.31, Buy rating PT $16.00), FRO (Frontline, EPS est
$2.74), CHA (Chagee Holdings). Also reporting: JFIN, BWLP, HAFN. No FDA or
acquisition catalysts surfaced; Kiplinger notes "no noteworthy earnings" while other
calendars list 6-12 small-cap reporters — treat as low-conviction, re-screen at
morning-research if any gap on volume.
Account equity EOD: $100,000.00
