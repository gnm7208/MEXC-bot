# Weekly Review

Friday/Sunday reviews appended below.

---

<!-- Format for each entry:

## Week ending YYYY-MM-DD

### Stats
| Metric              | Value  |
|---------------------|--------|
| Starting portfolio  | $X     |
| Ending portfolio    | $X     |
| Week return         | ±$X (±X%) |
| BTC week return     | ±X%    |
| Bot vs BTC          | ±X%    |
| Trades              | N (W:X / L:Y / open:Z) |
| Win rate            | X%     |
| Best trade          | SYM +X% |
| Worst trade         | SYM -X% |
| Profit factor       | X.XX   |

### Closed Trades
| Ticker | Entry | Exit | P&L | Notes |
|--------|-------|------|-----|-------|

### Open Positions at Week End
| Ticker | Entry | Price | Unrealized | Stop |
|--------|-------|-------|------------|------|

### What Worked
- ...

### What Didn't Work
- ...

### Key Lessons
- ...

### Adjustments for Next Week
- ...

### Overall Grade: X
-->

## Week ending 2026-07-19 (Week 1)

### Stats
| Metric              | Value  |
|---------------------|--------|
| Starting portfolio  | $10,000 |
| Ending portfolio    | $10,000 (last known — UNVERIFIED, API geo-blocked) |
| Week return         | $0 (0%) |
| BTC week return     | ~+0.9% (~$63,800 → ~$64,376) |
| Bot vs BTC          | −0.9% |
| Trades              | 0 (W:0 / L:0 / open:0) |
| Win rate            | N/A (no closed trades) |
| Best trade          | N/A |
| Worst trade         | N/A |
| Profit factor       | N/A |

### Closed Trades
None. No orders placed all week.

### Open Positions at Week End
None (last known: 100% USDT cash).

### What Worked
- Nothing to credit — the strategy was never exercised. Cash preservation is not a decision when no trade was possible.

### What Didn't Work
- **Exchange connectivity blocked the entire week — the bot has never traded.**
  - 2026-07-11: Binance API returned HTTP 451 (geo-restricted location).
  - Repo migrated Binance → Bybit Spot to resolve it (commits `b3138f8`, `8edc1c4`).
  - 2026-07-19: Bybit (`api.bytick.com` / `api.bybit.com`) returns HTTP 403 — CloudFront body: *"configured to block access from your country."* Same geo-block class, different exchange. Public market endpoints (`/v5/market/tickers`, `/v5/market/time`) also 403, so it is not a signing/auth issue.
- The migration did not fix the root cause: this execution environment's egress IP is geo-blocked by major exchange CDNs. Swapping exchanges without confirming reachability burned a week.

### Key Lessons
- Confirm the exchange API is actually reachable from the routine's egress **before** any trading logic matters. A reachability smoke test (`bybit.sh price BTCUSDT`) should gate every run and hard-fail loudly.
- Migrating exchanges to dodge a geo-block only helps if the new exchange isn't blocked from the same IP. Bybit and Binance are both blocked here.

### Adjustments for Next Week
- **Unblock connectivity is the only priority.** Options: (a) an exchange whose CDN is not geo-blocked from this environment (e.g. Kraken/Coinbase — verify reachability first), (b) a routing/egress change so exchange APIs are reachable, or (c) confirm whether the intended venue is US-accessible at all. No trading rule change will matter until quotes/orders resolve.
- Until then the bot is dark: 0 trades, 0 P&L, losing ground to BTC by whatever BTC does each week.

### Overall Grade: F
Zero trades executed in Week 1 of the challenge. The mission (beat BTC) was not pursued at all because the account/market API is unreachable, and the mid-week exchange migration did not restore access. Full week of the challenge window lost.

---

## Week ending 2026-07-26 (Week 2)

### Stats
| Metric              | Value  |
|---------------------|--------|
| Starting portfolio  | $32.32 (real MEXC account, funded 2026-07-22; Week 1's $10,000 was a stale pre-funding placeholder) |
| Ending portfolio    | $32.29 |
| Week return         | $0.00 (0.0%) — the $0.03 delta is display rounding, no trades |
| BTC week return     | ~+0.4% (~$64,376 on 07-19 close → $64,661 on 07-26) |
| Bot vs BTC          | −0.4% |
| Trades              | 0 (W:0 / L:0 / open:0) |
| Win rate            | N/A (no closed trades) |
| Best trade          | N/A |
| Worst trade         | N/A |
| Profit factor       | N/A |

### Closed Trades
None. No orders placed all week.

### Open Positions at Week End
None — 100% USDT cash ($32.29 free, 0 locked). Reachability gate PASS (MEXC `account`/`price`/`positions` all healthy).

### What Worked
- **Operational blocker resolved.** The Binance/Bybit geo-block that killed Week 1 is gone — the account now runs on MEXC Spot and the API is live and healthy every run (`canTrade=true`). This is the single biggest improvement over Week 1: the bot *can* trade now.
- **Discipline into a binary event.** Sat 100% cash ahead of FOMC (Jul 28–29, live ~33% hike tail) rather than getting caught in size before a coin-flip macro print on a $32 account. Defensible risk control.
- **Momentum gate did its job** on most sessions — majors (BTC/ETH/SOL) were flat-to-red and failed the +2% filter, correctly blocking low-quality entries.

### What Didn't Work
- **Second straight zero-trade week.** The mandate is "disciplined AND active" and to beat BTC; 0 trades = 0 pursuit of the mission. BTC rose ~0.4% while we held cash, so we lost ground again (small, but the direction is the point).
- **Declined valid gate-passing setups.** On 07-25, BANK (+28.66%), VVV (+5.07%) and ZRO (+5.00%) all passed the +2% momentum gate. All were declined on FOMC caution. Reasonable once — but the pattern of finding qualifying signals and taking none needs to break after FOMC clears.
- **Tiny-capital friction.** At $32.29, the 20% cap ≈ $6.46/position; MEXC min-notional plus fee/slippage is a heavier % drag than normal. Real, but not a reason to stay flat — it argues for a small number of higher-conviction entries, not zero.

### Key Lessons
- Capability is restored; the constraint is now *decision-making*, not connectivity. Week 1's excuse (API dark) no longer applies — inactivity from here is a choice, and it must be justified per-session, not defaulted to.
- Holding cash into a genuine binary macro event (FOMC) is fine. Holding cash *after* it clears, when gate-passing setups exist, is not.

### Adjustments for Next Week
- **Post-FOMC (after Jul 29): resume active deployment.** Once the FOMC print is out and digested, take the best gate-passing setup(s) — target 75–85% deployed per strategy — rather than defaulting to HOLD. First look: relative-strength names that held up pre-FOMC (BANK/VVV/ZRO) if still in momentum.
- Fixed a stale operational note in TRADING-STRATEGY.md: the reachability gate still referenced `scripts/bybit.sh` though the bot migrated to MEXC — corrected to `scripts/mexc.sh price BTCUSDT`.
- No hard trading-rule change warranted this week — the strategy behaved as designed (gate caution into a binary event). The gap is execution follow-through, not the rulebook.

### Overall Grade: D
Up from Week 1's F because the operational blocker is resolved and the account is genuinely trade-ready, and holding cash into a live-tail FOMC on a $32 account is defensible. But it is still a zero-trade week that trailed BTC by ~0.4%, with gate-passing setups declined. Two straight weeks of no trades in an "aggressive, active" mandate keeps the grade low; the bar for next week is clear — deploy after FOMC.

---

## Week ending 2026-08-02 (Week 3)

### Stats
| Metric              | Value  |
|---------------------|--------|
| Starting portfolio  | $32.29 (Jul 26 EOD, Week 2 close) |
| Ending portfolio    | $32.85 (Aug 2 EOD) |
| Week return         | +$0.56 (+1.73%) |
| BTC week return     | −2.41% (~$64,661 on 07-26 → $63,104 on 08-02) |
| Bot vs BTC          | **+4.14%** |
| Trades              | 3 actions → 1 closed round-trip (W:1 / L:0) + 1 open (ADA re-entry) |
| Win rate            | 100% (1/1 closed) |
| Best trade          | ADA +7.0% |
| Worst trade         | None (no losers) |
| Profit factor       | ∞ (gross profit $0.45 / gross loss $0.00) |

### Closed Trades
| Ticker | Entry | Exit | P&L | Notes |
|--------|-------|------|-----|-------|
| ADA | $0.16358 (Jul 29) | $0.17502 (Aug 1) | +$0.45 (+7.0%) | Full rulebook cycle — momentum entry, trailing stop tightened per Rule 7, closed at +7% TP. First realized win of the challenge. |

### Open Positions at Week End
| Ticker | Entry | Price | Unrealized | Stop |
|--------|-------|-------|------------|------|
| ADA | $0.18639 (Aug 2) | $0.1896 (EOD) | +$0.11 (+1.72%) | $0.1678 (−10%, monitored) |

### What Worked
- **First realized win of the entire challenge.** ADA ran the complete rulebook loop end-to-end: entered on a +2% momentum signal (Jul 29), trailed the stop up per Rule 7 as it rallied (+$0.1472 → $0.1626), and market-sold at the +7% take-profit the first time price tripped $0.1751 (Aug 1). No discretion, no override — the system produced the outcome it was designed to.
- **Beat BTC by ~4.14% in a down week.** BTC fell −2.41% (risk-off grind, F&G in Fear/Extreme-Fear all week) while the bot booked +1.73%. Outperforming buy-and-hold *while BTC declines* is exactly the mandate.
- **Disciplined re-entry, not revenge-trading.** After the Aug 1 exit, the bot did NOT chase ADA back up on a stale thesis. It waited, then re-entered Aug 2 only on a *fresh, documented* catalyst (Aug-9 SEC spot-ADA-ETF eligibility milestone + whale accumulation + a confirmed close above the $0.1809 breakout pivot). Textbook.
- **Momentum + quality/liquidity filters held.** Every session correctly rejected thin/pump/negative-catalyst movers (XMR fade-bounces, BNB stale catalysts, sub-$1M-vol names) instead of forcing size.

### What Didn't Work
- **Persistent under-deployment.** Ran a single ~20% position the whole week vs the 75-85% deployment target — 80% in cash every session. It worked out (the one position was a winner and BTC fell), but structurally this leaves most of the book idle. Only one qualifying liquid setup (ADA) appeared per session on the Fear tape, so this is partly opportunity-driven, but the gap is now three weeks running.
- **Low absolute trade count.** One completed round-trip. On a "disciplined AND active" mandate the activity is thin — though a clean +7% win beats a busy losing week, and the quality bar is the right one to keep.

### Key Lessons
- The rulebook *works when executed* — Week 3 is the proof. Weeks 1-2 failed on connectivity and decision-paralysis, not strategy design. The trailing-stop + take-profit mechanics captured a clean +7% with zero drawdown risk taken.
- Small-capital friction is real ($32 book, 20% cap ≈ $6.55/position, MEXC min-notional + fee drag), and it argues for a *small number of high-conviction entries* rather than spraying to hit 75-85% — but a single position is still light. The right target is 2-3 quality names when the tape offers them, not one.

### Adjustments for Next Week
- **Push toward 2-3 concurrent positions when qualifying setups exist.** Don't force deployment into junk, but when a second liquid name clears both the +2% gate and a genuine catalyst/quality bar, take it — one position at 20% is leaving the mandate's deployment target (75-85%) unmet by a wide margin.
- **Manage the open ADA re-entry to its rules:** hard cut $0.1733 (−7%), monitored stop $0.1678, take-profit $0.1994 (+7%), tighten to 7%-below-current at +3% gain. The Aug-9 ETF-eligibility milestone is the thesis checkpoint — re-assess if it slips or the breakout fails back below the pivot.
- **No trading-rule change warranted.** The strategy behaved exactly as designed and produced the first win. The gap is deployment breadth (execution), not the rulebook. TRADING-STRATEGY.md left unchanged.

### Overall Grade: B
Up two letters from Week 2's D. The bot booked its first-ever realized win (ADA +7.0%), ran the full rulebook cycle cleanly with zero rule violations, and beat BTC by ~4% in a week BTC fell — the core mission, delivered. Held back from an A by persistent under-deployment (one ~20% position, 80% idle cash, three weeks running) and thin trade count. Strong, disciplined week; the clear next step is deploying broader when quality setups appear.

---

## Week ending 2026-08-09 (Week 4)

### Stats
| Metric              | Value  |
|---------------------|--------|
| Starting portfolio  | $32.85 (Aug 2 EOD, Week 3 close) |
| Ending portfolio    | $33.58 (Aug 9 EOD, $33.5845) |
| Week return         | +$0.73 (+2.24%) |
| BTC week return     | +3.41% ($63,104 on 08-02 → $65,255.75 on 08-09) |
| Bot vs BTC          | **−1.17%** (first losing week vs benchmark) |
| Trades              | 1 closed round-trip (W:1 / L:0), 0 new entries, 0 open at close |
| Win rate            | 100% (1/1 closed) |
| Best trade          | ADA +12.9% |
| Worst trade         | None (no losers) |
| Profit factor       | ∞ (gross profit $0.84 / gross loss $0.00) |

### Closed Trades
| Ticker | Entry | Exit | P&L | Notes |
|--------|-------|------|-----|-------|
| ADA | $0.18639 (Aug 2) | ~$0.2110 (Aug 6) | +$0.84 (+12.9%) | ETF-eligibility re-entry (carried in from Wk3 as open). Full rulebook cycle — trailed stop up per Rule 7, market-sold at +12% TP into the Aug-9 SEC spot-ADA-ETF eligibility milestone. 2nd realized win of the phase. |

### Open Positions at Week End
None — 100% USDT cash ($33.5845 free, 0 locked). Reachability gate PASS all sessions.

### What Worked
- **Second clean win, best single trade of the challenge.** ADA re-entry ran the full loop: entered Aug 2 on the ETF-eligibility catalyst + trendline breakout, trailed the stop up per Rule 7 ($0.1678 → $0.1822), and market-sold at +12.9% ($0.2110) the first time price tripped the $0.2088 target Aug 6. No discretion, no override — the +12% take-profit rule executed exactly as written. Phase record now 2W/0L.
- **Discipline against parabolic chases.** Every liquid full-board qualifier this week was a blow-off (SKYAI, EPIC, TUT +178%, ISEK, CYS) — all correctly disqualified on the 3-Candle Confirmation Gate + Layer 3 exit-liquidity. Zero forced entries into microcap pump-and-dumps.
- **Sold the milestone, not the hope.** Took the +12.9% into the Aug-9 eligibility date rather than holding through headline whipsaw (eligibility ≠ approval; SEC decision window to ~Oct 23). Aug-9 passed with no SEC action → catalyst spent, validating the exit.

### What Didn't Work
- **Trailed BTC for the first time (−1.17%).** The mission is to beat BTC buy-and-hold; this week BTC rallied +3.41% while the book — ~20% deployed, then 100% cash for the final 3 days (Aug 7/8/9) — returned only +2.24%. A single winning trade on a ~20% position cannot keep pace with a 100%-benchmark in an up week. **The chronic under-deployment finally carried a measurable cost vs the benchmark.**
- **Three straight days at 100% cash into a rising tape.** After the Aug-6 exit, no rules-clean alt qualifier appeared (ADA momentum decayed post-catalyst; TAO cleared momentum but failed the $3M liquidity floor every scan; everything else parabolic-thin). Correct per the rulebook — but the rulebook left the book fully idle while BTC ground higher, guaranteeing relative underperformance.
- **Under-deployment now 4 weeks running.** ~20% peak deployment vs the 80-90% target. Weeks 1-3 it didn't cost vs-BTC (BTC flat/down); this week it did.

### Key Lessons
- **Sitting 100% cash while BTC rises is a guaranteed loss against the benchmark, even when the closed trades are winners.** Discipline on alt-entry quality is right — chasing TUT/EPIC would have been worse. But "no clean alt setup" defaulting to 0% deployment ignores that BTC itself is the thing we must beat. If alts don't qualify, holding cash concedes the benchmark; holding *BTC* at least matches it.
- The entry gates (momentum ≥ +5%/+2% AND ≥ $3M vol AND 3-candle AND EMA-200) are strict enough that in a Fear tape only one catalyst name (ADA) ever qualified all phase. When it closed, nothing replaced it. This is by design for alt quality — but it needs a benchmark-tracking floor so dry spells don't concede to BTC.

### Adjustments for Next Week
- **New Rule 12 added to TRADING-STRATEGY.md — Benchmark-Tracking BTC Core.** When ≥3 consecutive scan sessions yield zero rules-clean alt entries, macro is not halted, and deployment < 40%, allocate a ~30-40% core tranche to BTC (or ETH) spot as a benchmark-tracking hold — exempt from momentum-gate churn and the +12% TP, exited only if macro halts or capital is needed for a qualifying alt. Directly fixes this week's failure mode: never sit 100% cash conceding BTC during alt dry spells.
- Keep the alt-entry quality bar unchanged — the parabolic-chase discipline is correct and must not be loosened. The fix is a floor on idleness, not a loosening of alt gates.
- Manage any BTC core to Rule 12 (hold, don't churn); redeploy to a qualifying alt the instant one clears the buy-side gate.

### Overall Grade: B−
Down a half-step from Week 3's B. The trade execution was the best of the challenge — a textbook +12.9% ADA cycle, 100% win rate, phase 2W/0L, and phase-to-date still ahead of BTC (+3.91% vs +2.76%). But a weekly review grades the week, and this week the book **lost to its own benchmark for the first time** (−1.17%): BTC rallied +3.41% while a ~20%-deployed-then-all-cash book returned +2.24%. The under-deployment flagged for four straight weeks finally cost relative performance. Excellent trade, but the mission metric slipped this week — hence the rule change to stop conceding BTC during dry spells.

---

## Week ending 2026-08-16 (Week 5)

### Stats
| Metric              | Value  |
|---------------------|--------|
| Starting portfolio  | $33.5845 (Aug 9 EOD, Week 4 close) |
| Ending portfolio    | $33.2418 (Aug 16 EOD) |
| Week return         | −$0.34 (−1.02%) |
| BTC week return     | −3.27% ($65,255.75 on 08-09 → $63,124.33 on 08-16) |
| Bot vs BTC          | **+2.25%** (back ahead of benchmark) |
| Trades              | 1 action (BTC-CORE buy Aug 10) — 0 closed round-trips (W:0 / L:0 / open:1) |
| Win rate            | N/A (0 closed trades) |
| Best trade          | N/A |
| Worst trade         | N/A |
| Profit factor       | N/A (no realized P&L) |

### Closed Trades
None. Zero round-trips this week — the only action was opening the BTC-CORE (Rule 12) index-tracking hold on Aug 10. (The ADA +12.9% Aug-6 win belongs to Week 4; the trade-log's rolling counter carries it, but it is not a Week-5 close.)

### Open Positions at Week End
| Ticker | Entry | Price | Unrealized | Stop |
|--------|-------|-------|------------|------|
| BTC-CORE | ~$65,020 (Aug 10) | $63,124.33 | −$0.34 (−2.92%) | none (Rule 12 exempt) |

### What Worked
- **Back ahead of the benchmark (+2.25 pts).** BTC fell −3.27% on the week while the book returned only −1.02% — the mission (beat BTC buy-and-hold) was met after Week 4's first-ever benchmark miss.
- **No-chase discipline held through a garbage tape.** Every liquid full-board mover all week was a parabolic-thin pump/rug (MY +277%, TUT, RAZOR +98%, CYS, 龙虾 +66%) — all correctly disqualified on the 3-Candle Gate + Layer 3 exit-liquidity. Chasing any of them would have lost money. 22+ consecutive scans with zero rules-clean alt qualifier; the bot forced nothing.
- **Rule 12 (new Wk4) executed cleanly on its trigger.** ≥3 dry scans + macro not halted + <40% deployed → a ~34% BTC core was established Aug 10, avoiding a 100%-cash week. The core stayed a disciplined index-hold (no churn, no forced stop/TP), exactly as designed.

### What Didn't Work
- **Negative absolute return, and the sole deployed position is underwater.** −1.02% on the week; BTC-CORE closed −2.92%. Nothing was actively earned — the week was fully passive.
- **The +2.25-pt outperformance was direction-luck, not edge.** The book beat BTC because it was ~66% cash while BTC fell — not because of any active trade. Had BTC *risen* this week, the same 66%-cash book would have trailed again (the exact Week-4 failure). And a 100%-cash week would have beaten BTC by *more* (+3.27 vs +2.25): the BTC-CORE actually *dragged* relative performance this particular week because BTC fell.
- **Fifth straight week under-deployed / zero alt trades.** The whole phase has produced only 2 alt round-trips (both ADA). The strict alt gates + persistent Fear tape (F&G 27–34 all week) mean essentially nothing ever qualifies. Rule 12 floors the idleness with BTC but does not solve it.

### Key Lessons
- **Rule 12 is trend-blind, and this week exposed the trade-off.** It deploys a fixed ~30–40% BTC core during any dry spell regardless of BTC's own trend. That is correct when BTC rises (Week 4's problem — don't concede) but *costs* when BTC falls (this week — the core dragged, cash would have been better). Over a full sample the up/down weeks should roughly wash on the core slice while the cash portion carries the "beat BTC" edge — but two consecutive weeks (Wk4 BTC +3.4% / Wk5 BTC −3.3%) now bracket both regimes and make the tension concrete. Whether a trend-aware core (hold BTC only when BTC momentum is non-negative, else cash) beats the fixed core is the open question — but one down-week is not enough evidence to add a BTC-timing filter, which would re-introduce exactly the discretion Rule 12 was built to remove.
- **The scoreboard says "beat BTC," but the *reason* matters.** Beating a falling benchmark by holding cash is not the same as an active edge. The structural under-deployment problem is unresolved — it simply didn't bite this week because BTC happened to fall.

### Adjustments for Next Week
- **No live rule change.** The strategy behaved as designed: quality gates correctly rejected every pump, Rule 12 fired on its trigger, sell-side/exit logic had nothing to act on. One BTC down-week is not grounds to bolt a BTC-timing filter onto Rule 12 mid-phase with 6 days left — that decision belongs to the Aug-22 phase-parameter recalibration, on the full-phase sample.
- **Flagged for the Aug-22 review** (added to TRADING-STRATEGY.md "Phase Parameter Validation"): does a trend-aware BTC core (deploy only when BTC momentum ≥ 0) beat the fixed 30–40% core? And is the alt-entry gate *too* strict for a Fear regime — 2 alt trades in 5 weeks — or is that correct discipline given the tape was genuinely junk?
- **Aug 17–22 (final aggressive stretch, then revert):** manage BTC-CORE to Rule 12 (hold; exit only on macro halt, capital-for-alt, or −10% ≈ $58,518). Redeploy to any alt that *cleanly* clears the buy-side gate — do not loosen gates to force it. Then execute the scheduled conservative revert on Aug 22.

### Overall Grade: B−
The book beat its benchmark (+2.25 pts) — the literal mission — with correct no-chase discipline through a week of nothing but pump-and-dump tape, and Rule 12 executed exactly as written. That keeps it out of C territory. But it was a fully passive, absolute-negative week (−1.02%) whose only deployed position (BTC-CORE) finished underwater, and the outperformance owed more to BTC's direction (a −3.3% down-week met with a 66% cash cushion) than to any earned edge. The five-week under-deployment problem is unresolved. Same grade as Week 4 by a different route: Week 4 had an excellent trade but *lost* to BTC; Week 5 had no active trade but *beat* BTC — the two roughly offset. Last full week of aggressive mode; phase-to-date still ahead (+2.85% vs BTC −0.59%, 2W/0L closed).

---

## Week ending 2026-08-23 (Week 6) — *run 2026-08-26, 3 days late (scheduler gap, see below)*

### Stats
| Metric              | Value  |
|---------------------|--------|
| Starting portfolio  | $33.2418 (Aug 16 EOD, Week 5 close) |
| Ending portfolio    | $35.7685 (Aug 22 EOD — no activity Aug 23, routine gap) |
| Week return         | +$2.5267 (+7.60%) |
| BTC week return     | +22.34% ($63,017.07 Aug 16 → $77,109.16 Aug 23) |
| Bot vs BTC          | **−14.74%** (worst benchmark miss of the phase) |
| Trades              | 1 (W:1 / L:0 / open:0) |
| Win rate            | 100% (1/1 closed) |
| Best trade          | BTC-CORE +18.58% |
| Worst trade         | None (no losers) |
| Profit factor       | ∞ (gross profit $2.18 / gross loss $0) |

### Closed Trades
| Ticker | Entry | Exit | P&L | Notes |
|--------|-------|------|-----|-------|
| BTC-CORE | ~$65,020 (Aug 10) | ~$77,099 (Aug 22) | +$2.184 (+18.58%) | Rule-12 index-tracking hold. Closed proactively ahead of a multi-day unmonitored gap (subscription lapse risk) to lock the gain — not a rules-based stop/TP exit. |

### Open Positions at Week End
None — 100% USDT cash ($35.7685).

### What Worked
- Rule 12's BTC-CORE caught the largest BTC rally of the phase (~+20% in days) and booked +18.58% real profit — an index-tracking hold materially beat sitting in cash.
- Proactive close ahead of a known monitoring gap (subscription lapse) was the right call — it locked a large unrealized gain instead of leaving a live position unattended.
- No-chase discipline held all week: every full-board mover (KII, UPC, ETHFI, XPLK, PUMP, BTW, RAZOR) was correctly disqualified on the 3-Candle Gate or EMA-200 trend filter. Zero forced alt entries.

### What Didn't Work
- **Worst benchmark trail of the entire phase: −14.74 pts.** Bot +7.60% vs BTC +22.34%. Root cause: only ~35% of the book was ever in BTC-CORE — the other 65% sat in cash through one of BTC's sharpest weekly rallies. A fixed 30-40% core cap cannot track a >20% BTC move even when the core call is correct.
- **A 3-day scheduler outage compounded the miss.** morning-research/morning-execution did not fire from the night of Aug 19 through Aug 22 — BTC ran from ~$64,500 to ~$78,000 "blind," with no macro/signal-gate data available to size up the core or catch a breakout. Sibling `alpaca/` routines kept firing in the same repo over the same window, so this is a MEXC-bot-specific scheduler/cron issue, not a platform-wide outage or a market condition.
- **This weekly-review itself ran 3 days late** (scheduled Sun Aug 23, actually run Aug 26). AGGRESSIVE MODE's Aug-22 end date passed with no revert to CONSERVATIVE MODE — flagged as unresolved across 4+ subsequent TRADE-LOG entries (Aug 24-26) before this review finally actioned it.

### Signal Score Retrospective
Across the **entire phase** (Jul 22 – Aug 22), only 3 trades ever closed, and **none were scored by the Layer-2 signal system** introduced Aug 4:
- **Unscored (pre-Aug-4 entries):** ADA Jul29→Aug1 (+7.0%), ADA Aug2→Aug6 (+12.9%). 2 trades, 2 wins, 100% win rate, avg +9.95%. Best: ADA +12.9%. Worst: ADA +7.0% (still a win).
- **Tier A (score 5-7):** 0 closed trades.
- **Tier B (score 8-10):** 0 closed trades.
- **Tier C (score 11+):** 0 closed trades.
- **Rule-12 BTC-CORE (exempt, not part of the scoring system):** 1 trade, win, +18.58% (Aug10→Aug22).

**Threshold check: N/A.** Fewer than 5 scored closed trades exist — in fact zero. Every alt-entry scan since Aug 4 that reached Layer 2 scoring was disqualified before a fill (3-Candle Gate, EMA-200, liquidity floor). **Notable finding: the signal-scoring system has never produced a single live trade to validate it in its first 3 weeks of existence.** No threshold adjustment is possible or warranted from this data.

### Key Lessons
- Rule 12's fixed 30-40% cap means even a *correct* BTC-core call can't close a >20% benchmark gap in one week — that's a structural sizing limit, not a tactical one.
- Automation reliability is now a bigger risk to phase performance than the trading rules themselves: a 3-day silent scheduler gap on this specific bot cost more in unrealized opportunity than any single bad trade this phase. Needs a human check on the MEXC-bot cron/scheduler config (distinct from `alpaca/`, which kept running).
- A routine that goes 3 days without writing to memory/ or committing should be caught by monitoring well before a human notices it in a session log — there is currently no such alert.

### Adjustments for Next Week
- **AGGRESSIVE MODE (Aug 4-22) has ended. memory/TRADING-STRATEGY.md is being reverted to CONSERVATIVE rules in this same commit**, per CLAUDE.md's own instruction ("revert after Aug 22"), now 4 days overdue.
- **Phase Parameter Validation (resolved this review, per memory/TRADING-STRATEGY.md's "Phase Parameter Validation" section):**
  - *Trend-aware vs. fixed BTC core:* not carried into conservative mode (Rule 12 doesn't exist there). For any future aggressive phase: this week's evidence shows the binding constraint was the fixed 30-40% **size cap**, not the core's direction-blindness — a trend filter alone would not have closed a >20%-BTC-week gap.
  - *Alt-entry gate strictness:* validated, not loosened. 2/2 alt trades across the phase were winners (+7.0%, +12.9%), and every rejected mover that was checked showed a genuine disqualifying reason (thin/spent pump, downtrend bounce). Conservative mode's comparable gate is kept as-is.
- **Operational escalation (out of this routine's authority to fix):** the MEXC-bot scheduler/cron gap (Aug 19 night – Aug 22, and again Aug 23-24) needs a human check. Flagged in this week's ClickUp message.
- CLAUDE.md's "Strategy Hard Rules — AGGRESSIVE MODE (Aug 4–22)" section header is now stale now that TRADING-STRATEGY.md has reverted — recommend the user update it; not edited here (outside routines/weekly-review.md's instruction set for this run).

### Overall Grade: C−
Real, disciplined, rules-clean execution whenever the bot actually ran — one clean +18.58% win, zero forced trades, a sound proactive close ahead of a known gap. But this is the worst week of the phase against the actual mission (beat BTC): −14.74 pts, driven by chronic under-deployment colliding with BTC's sharpest rally of the challenge, worsened by a 3-day scheduler outage the strategy had no way to trade through, and capped off by this review itself running 3 days late with the scheduled mode-revert left undone in the interim. Process failures did more damage this week than any trading decision.
