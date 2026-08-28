---
name: multi-routine-consensus
description: "INACTIVE — Architecture where 5 scout routines each monitor one signal source; a consensus executor fires only when 3+ confirm"
metadata:
  type: project
  status: INACTIVE
---

## Feature: Multi-Routine Consensus Architecture

**Source:** Video #24 (reiPfBnUBys) "Claude Released An investing Tool! (Underrated)"

**What it does:**  
Split the current monolithic morning-research routine into:
- 5 scout sub-routines running in parallel (Whale Alert, VC/on-chain, social momentum, DeFiLlama TVL, price/volume scanner)
- 1 consensus executor routine that reads all 5 scout outputs and fires an entry only when ≥3 scouts confirm the same ticker

**Activation condition:**  
Activate when:
1. Portfolio grows past $200 USDT (enough capital to warrant the infrastructure)
2. AND we have 50+ closed trades with validated signal weights (to know which scouts to trust)

**Why deferred:**
- Our ~$35 account doesn't justify cloud routine complexity or the API cost overhead
- A single routine already performs the same multi-source cross-check in Steps 4-6
- Meaningful benefit only when we need parallel execution speed (which daily cloud routines don't need)

**Implementation path when ready:**
1. Extract Steps 4A-4D into 5 separate routines, each writing to a shared `memory/SCOUT-SIGNALS-YYYY-MM-DD.md`
2. Create a `consensus-executor` routine that reads all scout files and runs Step 5-6 logic
3. Schedule all 6 at same time; consensus executor with 30min delay to ensure scouts complete
