# Classic DB Custom – Drop Rate Normalization

This repository contains a set of **idempotent database patches** that normalize and rebalance quest drop rates for Classic-era World of Warcraft content.

All changes are guided by a formal derivation contract that emphasizes **player experience, pacing, and historical fidelity**, while preserving **human judgment and flexibility**.

---

## Governing Contract

All drop-rate decisions in this repository are governed by the **Drop Rate Derivation Contract**.

See:
`DROP_RATE_CONTRACT.md`

The contract defines:

- What evidence is admissible
- How heuristics may be applied
- When documentation is required
- Where judgment is explicitly expected

It intentionally **does not prescribe fixed answers or rigid procedures**.

---

## Decision Philosophy

This repository treats drop-rate tuning as an **interpretive process**, not a mechanical one.

Rules and heuristics exist to:
- Anchor reasoning
- Prevent accidental regressions
- Preserve hard-won context

They are not intended to replace judgment or override situational understanding.

> **Heuristics inform decisions; they do not compel outcomes.**
> All deviations are acceptable when reasoned and documented.

---

## Collaboration Model

Work in this repository follows a consistent pattern:

1. Start from observed data (DB state, in-game behavior, player reports)
2. Identify signals, contradictions, and edge cases
3. Reason about pacing and player flow
4. Apply heuristics where helpful
5. Make a decision
6. Document only when the reasoning is non-obvious

This approach favors **clarity over ceremony** and **judgment over automation**.

---

## Scope and Intent

This repository aims to:

- Reduce punitive or accidental grind
- Preserve Classic-era intent without fossilizing upstream errors
- Normalize extreme values while respecting contextual variation
- Enable future contributors to reason consistently without rediscovering prior conclusions

It does **not** aim to:

- Enforce uniform drop rates
- Eliminate grind entirely
- Replace design judgment with formulas

---

## Final Note

This project encodes **how to think**, not **what to think**.

The contract exists to support collaboration across time, zones, and contributors without constraining legitimate reasoning or slowing iteration.
