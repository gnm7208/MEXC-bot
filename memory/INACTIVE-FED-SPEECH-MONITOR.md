---
name: fed-speech-monitor
description: "INACTIVE — Monitor FOMC/Fed speech dates and adjust macro gate weight on high-uncertainty days"
metadata:
  type: project
  status: INACTIVE
---

## Feature: Fed Speech / Macro Event Monitor

**Source:** Video #24 (reiPfBnUBys) "Claude Released An investing Tool! (Underrated)"

**What it does:**  
Before computing MACRO_SCORE in Step 3, check if today is within 24h of a major macro event (FOMC decision, Fed chair speech, CPI/PCE release, NFP). If yes, apply a volatility penalty to SIZE_MULTIPLIER (e.g., cap at 0.6 regardless of macro score) or flag as EVENT_DAY in the research log.

**Activation condition:**  
Activate when:
1. We have ≥20 closed trades AND
2. We have observed at least 1 case where a macro event caused a stop-out

**Current partial coverage:**  
Step 7 already includes a Risk Factors section: "Event risks: (NFP, FOMC, protocol unlocks, etc.)" — but this is a manual note, not an automated check.

**Implementation when ready:**  
Add to Step 3, before MACRO_SCORE computation:
```bash
bash scripts/perplexity.sh "Is there a Fed speech FOMC decision CPI PCE NFP release today or tomorrow $DATE?"
# If yes: EVENT_DAY=true; cap SIZE_MULTIPLIER at 0.6 regardless of MACRO_SCORE; note in Risk Factors
```

**Why deferred:**  
The macro gate already captures most of this via BTC 24h momentum (which drops on macro fear events). Adding an explicit event check adds complexity; defer until a macro-event stop-out is observed in TRADE-LOG.
