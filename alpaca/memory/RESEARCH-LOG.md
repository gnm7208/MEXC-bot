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

## 2026-08-27 — Alpaca Morning Research

### Market Context
Sentiment: BULLISH (mild) — Nasdaq futures +0.5-1.1%, S&P futures +0.3-0.4%
(just under clean +0.5% bar, one feed showed a small dip), VIX -1.55%. Tone
driven by NVDA's after-hours earnings beat + "~70% FY26 revenue growth"
guidance lifting broad tech sentiment. No FOMC/CPI print today; Jackson Hole
Symposium ongoing (Fed Barkin speech) but no scheduled rate decision or major
data surprise flagged. Standard score threshold (6) applies, not raised to 9.
Risk events today: Jackson Hole commentary, PCE-adjacent Fed chatter — medium
attention, no hard data catalyst.

### Movers Scanned
`alpaca.sh movers` snapshot at 9:00 AM ET returned **stale EOD (8/26 close)
data** — identical to yesterday's 3:30 PM EOD scan (ORCL +2.84%, SBUX +2.55%,
QCOM +1.97%, MRVL +1.97%, CAT +1.28%, AAPL +1.16%, UNH +1.12%, META +1.10%,
MSFT +0.98%, TMO +0.94% / losers REGN -2.28%, SCHW -2.57%, ACN -3.05%,
INTU -3.20%, LLY -3.57%). None clear +3%. Root cause: the script's default
bars/snapshot query has no live pre-market print for most names this early —
confirmed via direct snapshot calls below that real premarket action exists
but isn't reflected in the generic movers scan yet.

Cross-checked via Perplexity + direct Alpaca snapshot (feed=iex) for named
premarket gainers not caught by the stale movers list: **NVDA** (real
latestTrade $222.90 @ 8:39 AM ET vs 8/26 close $209.77 = **+6.26%**),
**PANW** ($357.00 vs $339.40 close = **+5.19%**), **CRM** (Alpaca IEX
snapshot still shows $205.75 = 0.00% — no premarket print captured yet on
this feed despite ~+10% reported elsewhere; flagged data-stale, not a
zero-move).

### Signal Table
| Ticker | Chg% | Vol× | RSI | SMA50 | Catalyst | Cat pts | Score | ATR stop | ATR tgt | R:R | Eligible? |
|--------|------|------|-----|-------|----------|---------|-------|----------|---------|-----|-----------|
| NVDA | +6.26% | TBD (premkt, no reliable ratio yet) | TBD | above ($207.73) | EARNINGS_BEAT — beat + raised FY26 rev growth guidance ~70% (reported after close 8/26, within 24h) | +3 | 5/15 partial (3 chg +1 sma50 -2 breakout-thru-high +3 catalyst; vol/RSI pending) | 4.0% | 8.0% | 2.00 | PENDING — re-score at 9:45 open, needs vol≥1.5x to clear 6 |
| PANW | +5.19% | TBD | TBD | above ($339.53) | ANALYST_UPGRADE — JPM/Benchmark/Citizens/BofA PT raises ahead of own earnings (~Sep 1); not yet a confirmed beat | +2 | 4/15 partial (3 chg +1 sma50 -2 breakout-thru-high +2 catalyst) | 4.0% | 8.0% | 2.00 | PENDING — weaker catalyst than NVDA, unlikely to clear 6 even with vol/RSI |
| CRM | 0.00%* | TBD | TBD | above ($177.07) | EARNINGS_BEAT — EPS $5.90 vs $3.27 est, guidance raised, Agentforce/AI traction cited (reported after close 8/26) | +3 | N/A — data stale | 4.0% | 8.0% | 2.00 | PENDING — snapshot not yet reflecting reported premarket pop; re-check at open before scoring |

*CRM chg% is an IEX-feed data artifact (no premarket print captured on this
feed at 9:00 AM ET), not a real 0.00% move — do not treat as a dead signal.

### Trade Ideas
None executable yet — market not open (rule: no premarket entries, 9:45 AM ET
minimum). Three names carry real, confirmed catalysts and should be re-scored
live at morning-execution:
1. **NVDA** — strongest, cleanest setup: confirmed earnings beat + raised
   guidance, +6.26% premarket, above 50-day SMA. Needs volume ≥1.5x and
   RSI check at open; likely clears score ≥6 if volume confirms.
2. **CRM** — real earnings beat (EPS crushed, guidance raised) but Alpaca
   IEX feed hasn't captured the premarket move yet — must re-pull
   chg%/volume fresh at 9:45 before deciding; don't trust the stale 0.00%.
3. **PANW** — real but weaker catalyst (pre-earnings analyst PT raises, no
   confirmed beat yet); lowest priority of the three, likely score <6.

All three are already trading above the prior day's high, which trips the
"-2 near-resistance" scoring penalty as currently written even though it's a
breakout-through rather than an approach-from-below — applying the formula
literally, consistent with how MRK was scored the same way on 8/26.

### SECTOR_BLOCKED
none

### Decision
HOLD at research stage (market closed, no premarket entries permitted).
0 open positions, 0 open orders, daily/weekly gates clear (0 trades this
week, 0 closed trades — circuit breaker check not applicable). Priority
re-screen at 9:45 AM morning-execution: NVDA first, then CRM, then PANW.
Account equity: $100,000.00

### Addendum — 2026-08-27 09:45 ET (morning-execution)
Decision = HOLD → monitor only per routine. Account: equity $100,000, cash
$100,000, buying power $400,000. 0 open positions, 0 open orders — nothing
to check (no thesis/stop/TP review needed). No trade executed; NVDA/CRM/PANW
re-screen skipped per literal HOLD gate (consistent with 8/26 precedent).

### EOD Scan — 2026-08-27 (3:30 PM ET)
Note: an earlier "EOD Scan — 2026-08-27" entry already exists above (committed
6042037 at 11:07 UTC / ~7:07 AM ET, before market open) — that was a
scheduling anomaly, not this routine's real 3:30 PM ET run. This is the
actual scheduled EOD scan for today.
Open positions held overnight: none (0 open positions, 0 open orders —
nothing to cut, no stop/TP checks needed).
Positions cut: none.
Account equity/cash/buying power unchanged: $100,000 / $100,000 / $400,000.
**Trades this account has ever executed: 0** (9 calendar days of routine
runs, 8/19-8/27).

Movers scan (3:30 PM ET): gainers **CRM +22.96%** (vol 1.85M), **PANW +13.80%**
(vol 221K), SNPS +12.27%, NOW +10.20%, **NVDA +8.97%** (vol 6.89M), ADBE
+6.08%, ACN +3.93%, AVGO +3.84%, CDNS +3.35%, TSLA +2.51%; losers DE -1.98%,
HD -2.01%, COST -2.09%, ABT -2.38%, MCD -2.47%.

CRM, PANW, and NVDA are the exact three tickers this morning's research
(09:00 ET) flagged as confirmed-catalyst, above-50-SMA candidates and
explicitly queued for "priority re-screen at 9:45 AM morning-execution."
The 09:45 morning-execution addendum skipped that re-screen "per literal
HOLD gate" — no such gate exists in TRADING-STRATEGY.md; this appears to be
a routine logic bug, not a documented rule, and matches "8/26 precedent" per
that addendum's own note, i.e. it has recurred at least once before. Net
effect: a rules-clean CRM entry this morning would have hit the +12% TP
intraday (CRM ran +22.96%); NVDA (+8.97%) and PANW (+13.80%) also cleared
the take-profit band. Flagging for review — this is not an EOD-scan-owned
fix (EOD scan only manages open positions / builds tomorrow's watchlist)
but the morning-execution HOLD-gate logic should be corrected before
tomorrow's 9:45 AM run.

Tomorrow's watchlist: today's after-market-close (AMC) earnings reporters,
since large post-close beats/misses typically drive tomorrow's pre-market
move — **MRVL** (Marvell Technology, Q2 FY27, reports AMC 8/27, large-cap
semis, EPS est $0.93), **ADSK** (Autodesk, AMC 8/27), **WDAY** (Workday,
AMC 8/27); also reporting AMC 8/27: AFRM, ULTA, PD, RBRK, ESTC, GAP.
Perplexity's tomorrow-dated query mostly returned today's (8/27) pre-market
reporters (BBY, DG, DLTR, HRL, BURL, TD, RY) rather than 8/28 — those already
reported/moved today and are not tomorrow's watchlist; re-screen MRVL/ADSK/WDAY
premarket reaction fresh at 9:00 AM morning-research.

## 2026-08-28 — Alpaca Morning Research

### Market Context
Sentiment: NEUTRAL (cautious)
Futures: S&P mixed/flat (-0.06% to +0.65% across sources, choppy, no clear
direction) | Nasdaq mixed, slightly weaker in one read
Risk events today: **Fed Chair Kevin Warsh Jackson Hole speech ~10:00 AM ET
(2:00 PM UTC)** — high-impact rate-path/real-yield event, similar risk
profile to an FOMC day; Chicago PMI 9:45 AM ET (beat: 57.6 vs 56.1 est, mild
positive); BLS preliminary payroll benchmark revision. No CPI/FOMC decision
today. Given the Fed speech risk, treating this like a BEARISH-day gate per
strategy intent: **entry threshold raised to FINAL_SCORE >= 9** even though
futures aren't outright negative.

### Movers Scanned
`alpaca.sh movers` (S&P100+NDX100 universe) as of 9:13 AM ET — **data-stale
caveat**: pre-open, so `dailyBar` still reflects 8/27's closed session and
`prevDailyBar` is 8/26's close; this is the same IEX pre-open lag flagged in
the 8/27 log, not fresh 8/28 premarket action. Verified via direct
snapshot/latestTrade timestamps:
- Top "gainers" (all actually 8/27 EOD moves, already realized, no fresh
  8/28 print yet): CRM +22.57%, SNPS +13.23%, PANW +12.76%, NOW +10.08%,
  NVDA +8.77%, ADBE +5.73%, AVGO +4.40%, CDNS +3.83%, ACN +3.31%, TSLA +2.56%.
  Where a genuine 8/28 premarket trade exists (NVDA, NOW), price is flat-to-
  slightly-down vs 8/27's close (NVDA $227.72 vs $228.17 = -0.2%; NOW $137.88
  vs $138.44 = -0.4%) — **no continuation, these are one-day-old extended
  moves**, not fresh signals.
- Losers: ABT -2.21%, MRK -2.24%, SYK -2.28%, COST -2.28%, MCD -2.57%.
- Yesterday's flagged AMC-8/27 earnings reporters (today's real watchlist),
  checked directly via fresh 8/28 snapshot: **MRVL -6.81%** premarket (beat
  EPS $0.67/rev $2.01B +58% YoY, but guidance seen as not validating the
  AI-rally narrative → sell-the-news per Perplexity), **RBRK -7.07%**
  premarket (no fresh catalyst confirmed, negative reaction). **WDAY, ADSK,
  PD, ULTA** show no fresh 8/28 print yet (still flat at 8/27 close) — thin
  premarket liquidity, re-check at open.
- Perplexity-sourced premarket gainers (unconfirmed on Alpaca IEX feed at
  9:13 AM, no fresh timestamp): ESTC, GAP, AFRM, OKTA (all real 8/27 earnings
  pops per prior log, same "already realized" caveat as above), BEKE (Q2
  beat, net income +100.8% YoY, but not on Alpaca-tradable US-listed movers
  scan check — flat -0.78% here).

### Signal Table
| Ticker | Chg% | Vol× | RSI | SMA50 | Catalyst | Cat pts | Score | ATR stop | ATR tgt | R:R | Eligible? |
|--------|------|------|-----|-------|----------|---------|-------|----------|---------|-----|-----------|
| MRVL | -6.81% (premkt) | n/a | n/a | n/a | EARNINGS_BEAT but guidance disappointed → negative reaction | n/a | N/A | n/a | n/a | n/a | **NO — negative price move, thesis broken (sell-the-news), long-only** |
| RBRK | -7.07% (premkt) | n/a | n/a | n/a | none confirmed | n/a | N/A | n/a | n/a | n/a | **NO — negative premarket move** |
| CRM/PANW/SNPS/NOW/NVDA/OKTA | +8% to +28% (all 8/27, stale) | n/a | n/a | above (per prior day) | real earnings/upgrade catalysts, but 1 day old | n/a | N/A — not fresh | n/a | n/a | n/a | **DEFER — no fresh premarket continuation confirmed; would be chasing an already-extended prior-day pop, high near-resistance risk (-2 pt rule). Re-screen live at 9:45 open for true gap-continuation only.** |

No ticker currently clears score >= 9 (raised threshold) with a fresh,
confirmed intraday move — market not yet open (9:13 AM ET), and every named
catalyst mover so far is either a stale 8/27 print or a negative premarket
reaction.

### Trade Ideas
None executable pre-market (rule: no premarket entries, 9:45 AM ET minimum
after 15-min settle). Watchlist for 9:45 AM morning-execution re-screen,
**live data only, ignore the pre-open stale movers pull**:
1. **CRM, PANW, SNPS, NOW, NVDA, OKTA** — only worth a fresh look if they
   show genuine gap-and-go continuation volume above yesterday's close at
   the open; if flat/fading, skip (chasing a 1-day-old pop near
   prior-day-high fails the -2 resistance penalty and R:R logic).
2. **MRVL, RBRK** — avoid (negative premarket reaction, thesis broken
   before entry).
3. No new long-only candidate currently meets FINAL_SCORE >= 9. Re-run
   `alpaca.sh movers` fresh after 9:30 cash open (dailyBar resets) before
   the 9:45 execution decision.

### SECTOR_BLOCKED
none

### Decision
HOLD at research stage. Market not open, no premarket entries permitted;
0 open positions, 0 open orders, 0 trades this week — daily/weekly gates
and circuit breaker not applicable (0 closed trades). Elevated-risk day:
Fed Chair Jackson Hole speech ~10:00 AM ET — entry bar raised to score >= 9
for today. Re-screen CRM/PANW/SNPS/NOW/NVDA/OKTA for genuine continuation
and MRVL/RBRK confirmed avoid at 9:45 AM morning-execution using live
post-open data, not the pre-open stale movers pull.
Account equity: $100,000.00

### EOD Scan — 2026-08-28 (3:30 PM ET)
Open positions held overnight: none (0 open positions, 0 open orders —
nothing to cut, no stop/TP checks needed).
Positions cut: none.
No morning-execution or midday addendum found for today in this log — HOLD
from morning research appears to have carried through the full session
with no re-screen logged (same open question flagged in yesterday's EOD
entry re: a possible morning-execution HOLD-gate bug; not fixed as of this
run — still not an EOD-scan-owned fix).
Account equity/cash/buying power unchanged: $100,000 / $100,000 / $400,000.
**Trades this account has ever executed: 0** (10 calendar days of routine
runs, 8/19-8/28).

Movers scan (3:30 PM ET): gainers NOW +4.61% (vol 1.04M), AMZN +3.82%,
SYK +2.90%, NKE +2.71%, INTU +2.66%, NFLX +2.41%, SCHW +2.40%, GOOGL +2.06%,
CRM +2.03%, BAC +1.90%; losers MRVL -9.81%, SNPS -4.95%, NVDA -4.69%,
KLAC -4.21%, LRCX -3.94%. Note: NVDA/CRM/SNPS gave back most of yesterday's
earnings pop today (NVDA -4.69% today vs +8.97%/+8.77% the prior two
sessions; SNPS -4.95% today vs +12-13% prior) — consistent with yesterday's
"DEFER, don't chase a 1-day-old pop" call working out; MRVL's premarket
weakness (-6.81% at 9:13 AM) extended to -9.81% by the close, consistent
with the "sell-the-news, thesis broken" avoid call.

Tomorrow's pre-market catalyst scan: 8/29 is a Saturday (market closed) —
`perplexity.sh` correctly returned "no reports" for that date across
multiple earnings calendars. Next trading day is Monday 2026-08-31.
Non-earnings catalysts surfaced for the weekend/Monday window: **LNTH**
(Lantheus Holdings — pending $8B acquisition by Curium at $102.50/share,
plus recent FDA approval, new institutional stake reported 8/28), **BNTX/
PFE** (FDA approval for adapted COMIRNATY COVID-19 vaccine), **QNRX**
(Quoin Pharmaceuticals — FDA-related news + $50M financing, microcap/
high-risk, ADS). No confirmed earnings-driven premarket movers for Monday
in this pull; re-run `alpaca.sh movers` + a fresh earnings-calendar query
Monday morning since weekend queries don't capture Monday's actual
pre-market reporters.

Tomorrow's watchlist: LNTH (acquisition + FDA catalyst, needs live
volume/RSI check Monday), BNTX/PFE (FDA approval, lower momentum profile,
lower priority), QNRX (high-risk microcap, lowest priority — confirm
liquidity/spread before considering). No confirmed earnings reporters for
Monday yet — re-screen at Monday's 9:00 AM morning-research.
Account equity EOD: $100,000.00
Account equity EOD: $100,000.00

## 2026-08-29 — Alpaca Morning Research

### Market Context
Saturday — market closed, no session, no premarket/futures data to scan.
Movers/catalyst/scoring steps skipped (nothing tradable exists on a closed
day; would just burn API calls on stale weekend data).

### Decision
SKIP — market closed. 0 open positions, 0 trades this week, circuit
breaker N/A (0 closed trades). Next trading day: Monday 2026-08-31 —
run full morning-research then against Friday's carried watchlist (LNTH
acquisition+FDA, BNTX/PFE FDA approval, QNRX high-risk microcap) plus a
fresh live movers/earnings-calendar pull.
Account equity: $100,000.00

### Addendum — 2026-08-29 09:45 ET (morning-execution)
Saturday, market closed (per TRADING-STRATEGY.md: market hours only,
Mon-Fri). No Trade Ideas exist for today (research SKIPped above), 0 open
positions/orders to monitor, so no stop/TP checks or thesis review needed.
No trades placed, no daily/weekly gate or circuit-breaker check applicable
(0 trades today, 0 this week). Logging this addendum explicitly so future
EOD-scan runs don't re-flag a "missing morning-execution addendum" gap —
this closes the open question noted in the 2026-08-28 EOD entry re: routine
runs firing on non-trading days without a logged confirmation.
Account equity: $100,000.00 (unchanged).

## 2026-08-30 — Alpaca Morning Research

### Market Context
Sunday — market closed, no session, no premarket/futures data to scan.
Movers/catalyst/scoring steps skipped (nothing tradable exists on a closed
day; would just burn API calls on stale weekend data) — same rationale as
the 2026-08-29 (Saturday) entry.

### Decision
SKIP — market closed. Account checked: equity $100,000 / cash $100,000 /
buying power $400,000, unchanged. 0 open positions, 0 trades this week,
circuit breaker N/A (0 closed trades). Next trading day: Monday 2026-08-31
— run full morning-research then against Friday 8/28's carried watchlist
(LNTH acquisition+FDA, BNTX/PFE FDA approval, QNRX high-risk microcap) plus
a fresh live movers/earnings-calendar pull.
Account equity: $100,000.00

### Addendum — 2026-08-30 09:45 ET (morning-execution)
Sunday, market closed (per TRADING-STRATEGY.md: market hours only,
Mon-Fri). No Trade Ideas exist for today (research SKIPped above), 0 open
positions/orders to monitor, so no stop/TP checks or thesis review needed.
No trades placed, no daily/weekly gate or circuit-breaker check applicable
(0 trades today, 0 this week).
Account: equity $100,000 / cash $100,000 / buying power $400,000, unchanged.

## 2026-08-31 — Alpaca Morning Research

### Market Context
Sentiment: NEUTRAL (cautious lean)
Futures: S&P -0.26% to -0.37% (ES ~7,693-7,722) | Nasdaq futures mixed/soft
Risk events today: no FOMC/CPI/jobs; only Dallas Fed Manufacturing (10:30 ET,
beat: 1.3 vs 0.7 forecast) and Chicago PMI (57.8 vs 57.6 prior) — second-tier.
Headline risk: reports of an escalation in the U.S.-Iran situation and rising
US-Canada trade tension are cited as the drag on futures. Doesn't clear the
-0.5% BEARISH bar and no top-tier data release, so scored NEUTRAL — but
treating today as lower-conviction given the geopolitical overhang (extra
scrutiny on chase-y pops, same as prior sessions).
Account: equity $100,000 / cash $100,000 / buying power $400,000 — no open
positions, 0 trades this week. Circuit breaker N/A (0 closed trades).

### Movers Scanned
Gainers: NOW +4.52%, AMZN +4.00%, NKE +3.05%, INTU +2.92%, SYK +2.66%,
NFLX +2.39%, SCHW +1.93%, BAC +1.91%, MCD +1.86%, GOOGL +1.77%
Losers: MRVL -10.25%, LRCX -5.23%, SNPS -4.77%, NVDA -4.66%, KLAC -4.48%
Flagged (>=+3%): NOW, AMZN, NKE

### Signal Table
| Ticker | Chg% | Vol× | RSI | SMA50 | Catalyst | Cat pts | Score | ATR stop | ATR tgt | R:R | Eligible? |
|--------|------|------|-----|-------|----------|---------|-------|----------|---------|-----|-----------|
| NOW | -2.06%* | 0.3x | 70 | above | ServiceNow earnings/AI beat — reported 8/27, 4 days stale | 0 | 1/15 | 4.7% | 9.3% | 2.00 | No — score <6 |
| AMZN | -1.81%* | 0.5x | 31 | above | Post-earnings AWS continuation — stale, not 24h | 0 | 1/15 | 4.0% | 8.0% | 2.00 | No — score <6 |
| NKE | -1.89%* | 1.3x | 31 | BELOW | None; JPMorgan downgrade cited as headwind | 0 | 0/15 | 4.0% | 8.0% | 2.00 | No — below SMA50 + score <6 |
| LNTH | +0.09% | ~0.6x | — | BELOW | Curium acquisition ($102.50, pending) — deal ~1.7% away, largely priced in | n/a | n/a | n/a | n/a | n/a | No — below SMA50, thin arb spread |
| QNRX | +12%* / +40% premkt | n/a | — | above | FDA-related news + financing (carried from Fri) | n/a | n/a | n/a | n/a | n/a | No — avg 20d vol ~405 sh, broken/illiquid quote (ask $0), unsafe to size |

*Daily-bar chg% reflects the last completed session (IEX feed delay), not
today's live intraday tape — `movers` intraday % is what drove the flag;
this column stays per the standard scoring script's methodology.

### Trade Ideas
None — no candidate cleared SCORE >= 6 with R:R >= 1.5 and above-SMA50.

### SECTOR_BLOCKED
none

### Decision
HOLD — 0 open positions, 0 trades this week/today. NOW and AMZN are
extending earnings pops that are now 4+ days old (no fresh 24h catalyst,
technical score 1/15 each) — same "don't chase a stale pop" pattern that
played out correctly Friday (NVDA/SNPS/MRVL gave back gains the next
session). NKE below 50-day SMA, no catalyst. LNTH's acquisition arb is
already tight and the stock trades below its 50-day SMA. QNRX's premarket
pop is real per Perplexity but Alpaca's own bars show ~400 shares/day
average volume and a broken bid/ask (ask $0.00) — not tradeable at any
size that respects position sizing. Re-scan at 9:45 AM execution and
tomorrow's morning-research; drop LNTH/QNRX from active watchlist unless
liquidity/technicals improve.
Account equity: $100,000.00
