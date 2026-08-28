---
name: signal-type-win-rate
description: "INACTIVE — Track win rate by entry type (Option A/B/C) in self-learning step; activate when 15+ closed trades available"
metadata:
  type: project
  status: INACTIVE
---

## Feature: Signal-Type Win Rate Tracking

**Source:** Video #27 (mssPkDuQnmY) "How To Build Your Own Claude AI Trading Assistant"

**What it does:**  
In Step 1B (Self-Learning Trade Review), also compute win rate broken down by entry *type* (Option A = pure price+volume momentum, Option B = catalyst, Option C = multi-source confirmation), not just by signal score band. This reveals whether one entry type systematically outperforms or underperforms, informing which signals to prioritize.

**Activation condition:**  
Activate when TRADE-LOG has **15+ closed trades** across at least 2 entry types.  
*(We have 3 closed trades as of Aug 2026 — not enough for statistical validity.)*

**Implementation:**  
Add to Step 1B in `routines/morning-research.md` after the score-band win rate block:

```
  Also compute win rate by entry type (requires >= 5 trades per type to flag):
  - Option A (price momentum ≥5% + vol ≥$3M): N_trades, N_wins → win_rate_A
  - Option B (catalyst-driven): N_trades, N_wins → win_rate_B
  - Option C (3+ source confirmation): N_trades, N_wins → win_rate_C

  Flag if any type with >= 5 trades has win_rate < 40%: TYPE_WEAK: [A/B/C]
  Log: self-learning type: A X/Y wins | B X/Y wins | C X/Y wins | weak: [types or none]
  Adjust: if TYPE_WEAK for a type, require score >= 9 for entries of that type.
```

**Why deferred:** Win rates on 2-3 trades per type are noise, not signal.
