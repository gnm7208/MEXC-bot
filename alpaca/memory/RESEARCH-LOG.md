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
