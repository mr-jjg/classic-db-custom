Version: 3.0
Last updated: 2026-01-02

# CMaNGOS Quest Drop Tuning – Collaboration Protocol

## Purpose
This document defines the exact workflow and input/output contract used to tune quest-related drop rates in the CMaNGOS Classic WORLD database, specifically `creature_loot_template`.

The goals are:
- Correct inaccurate upstream data
- Preserve reproducibility
- Enable aggressive iteration with safe rollback
- Avoid re-discovery and re-argument months later

This protocol is written for long-term, repeated collaboration.

---

## Scope
- Database: `v_mangos`
- Primary table: `creature_loot_template`
- Primary field: `ChanceOrQuestChance`
- Strategy: Zone-by-zone review, item-by-item corrections
- Patch style: Deterministic SQL patches (idempotent)

---

## Roles

### Human (Joel)
- Researches quest item drop behavior (primarily via Wowhead Classic)
- Decides *intent*:
  - Which mobs should drop an item
  - Which mobs should not
  - Approximate or exact drop chances
- Provides structured input data

### Assistant (Orb Weaver)
- Validates consistency (DB state vs spreadsheet vs sources)
- Cross-checks creature `entry` against `MOBLINK`
- Generates clean, idempotent SQL patches
- Flags ambiguities, omissions, or unsafe assumptions
- Interprets `new_value` as already policy-derived and applies it verbatim,
  preserving sign semantics unless a contradiction is detected.

---

## Authoritative Sources
- Primary discovery index per zone:
  - Example: https://www.wowhead.com/classic/items/quest?filter=16;85;0
- Item- and quest-specific pages linked from the index
- Observational data is treated as directional, not absolute truth

---

## Decision Philosophy (Important)

- Items should only exist on mobs that meaningfully drop them
- Near-zero observed drops are corrected by **removal**, not by tiny chances
- Spurious cross-zone droppers for localized quest items are removed, even if present in the upstream database.

### Interpretive Principle

Heuristics in this document inform decisions; they do not compel outcomes. When heuristics point in different directions, a reasonable conclusion must be drawn using the totality of evidence. Any non-obvious deviation from a default recommendation must be briefly reasoned and documented.

### Deletion Rule
If a mob should not drop an item:
- The `(entry, item)` row is **deleted**
- Chance is **not** set to `0`

---

## Drop Rate Derivation Policy (Authoritative)

Wowhead drop percentages are directional telemetry. They are neither a strict floor nor a strict ceiling. They are an anchor for policy-derived values, subject to the Bugfix Exception rules below.

### Rounding and Boosting Rules
Let `val` be the Wowhead percentage for a mob-item pair.

1. Compute `c = ceil(val)`.

2. Derive `new_val` using the following rules:
   - If `val <= 10`:
     - `new_val = c + 1`
   - Else if `val <= 20`:
     - `new_val = next_multiple_of_5(c)`
   - Else:
     - `new_val = next_multiple_of_10(c)`

3. **Equalization rule (recommended):**
   - For the same item within a patch (or within a clearly defined mob group),
     all UPDATE rows may be normalized to the **maximum derived `new_val`**
     to avoid encouraging mob targeting.

### Rounding vs Equalization Distinction
Rounding determines the candidate new_val for each mob.
Equalization is a secondary normalization step and is optional.

Declining equalization is appropriate when:

   - Wowhead telemetry shows persistent, population-stable stratification across mob types, and
   - Player comments reinforce differentiated targeting rather than random variance.

In such cases, heterogeneous new_val assignments may be used instead of forced uniformity, provided a reasonable conclusion is drawn and documented.

### Sample Size Gravity (Heuristic)
When multiple mobs drop the same item:

   - Telemetry from high-population mobs generally provides more stable signals than rare or named mobs.

   - Low-population mobs may exhibit significant variance without implying a different intended rate.

This heuristic exists to support reasonable conclusions, not to impose strict precedence. Conflicting signals should be resolved using overall quest context, comparable items, and player experience.
	 
### High-Value Outlier Correction (Exception)
A reduction to an existing ChanceOrQuestChance value is allowed when any one of the following conditions is met:

1. Magnitude delta rule
   - abs(db_val) >= 60 and
   - abs(db_val) - abs(new_val) >= 30

2. Quest collapse rule
   - At the existing DB value, the quest’s required item count is likely to complete in
     considerably fewer kills than intended, as implied by
      - Comparable quests in the same level band, or
      - Player-reported experience in Classic-era comments.

Player comments consistently contradict the DB value, even where Wowhead telemetry is noisy, and should be treated as behavioral diagnostics, not numeric evidence. Comments primarily indicate:

   - Targeting errors (wrong mob types)
   - Quest-state misunderstandings
   - Competition pressure
   - Variance amplification due to small samples

Numeric inference should only be drawn when:
   - Complaints persist across patches and
   - Are corroborated by telemetry or comparable quest structure.

### Pacing Compensation Rule
Applying telemetry-derived corrections can unintentionally add excessive grind time when values collapse from -80 or -100 to much lower policy-derived rates. To prevent punitive outcomes, the policy-derived new_val is treated as a lower bound, not a mandatory target.

When such a collapse occurs, a pacing compensation may be applied as follows:

1. Punish Compensation: If the magnitude reduction is extreme (e.g., -80 or greater reduced to -30 or similar), add +10 percentage points to the policy-derived value. This compensation is applied once and reflects the base cost of a major normalization.

2. Competition Compensation: For each non-quest, non-rare mob type that materially shares the same camp or respawn pool and increases effective grind (by diluting spawns, interfering with pulls, or occupying spawn nodes), add +5 percentage points per mob type.

3. Caps and Guardrails:
   - Total pacing compensation is capped at +30 percentage points.
   - The resulting value must not exceed -60 unless historical evidence supports a higher rate.
   - Rare and elite mobs are excluded from competition compensation unless the quest explicitly targets them.

All such pacing compensations must be briefly documented in the per-item Notes block of the patch for traceability.

### Quest-Conditional Semantics
- If the existing database value is quest-conditional (negative),
  the derived value **must remain negative**.
- If the existing database value is normal (positive),
  the derived value **must remain positive**.

Example:
- Derived `new_val = 50`
  - Normal drop → `50`
  - Quest-conditional drop → `-50`


---

## Input Contract (What Joel Sends)

### Preferred Format
A table (spreadsheet or pasted text) with the following columns:

| Column     | Required | Purpose |
|-----------|----------|---------|
| patch_id  | Yes      | Groups rows into one patch |
| zone_id   | Yes      | Context only (e.g. 85) |
| MOBLINK   | Yes      | Wowhead NPC URL (used for validation) |
| entry     | Yes      | Creature entry ID (authoritative) |
| item_id   | Yes      | Item ID |
| action    | Yes      | UPDATE or DELETE |
| new_value | Cond.    | Required for UPDATE; blank for DELETE |
| comment   | Yes      | Human-readable item name |

### Action Semantics
- `UPDATE` → Set `ChanceOrQuestChance = new_value`
- `DELETE` → Remove row entirely from `creature_loot_template`

### Numeric Conventions
- `new_value` represents a **policy-derived final chance**, not a raw Wowhead percentage.
- Whole numbers are preferred and expected in most cases.
- Decimal precision beyond whole numbers is discouraged unless explicitly justified.
- The **sign** of `new_value` is semantically meaningful:
  - Positive values → normal drops
  - Negative values → quest-conditional drops (only if eligible/on quest)

### Validation Expectations
- `entry` must match `npc=<id>` in `MOBLINK`
- One `(entry, item_id)` pair per row
- No conflicting actions for the same pair

---

## Additional Context Joel Will Provide
- Current DB state query:
  ```sql
  SELECT * FROM creature_loot_template WHERE item = <item_id>;
```
- Wowhead drop table text (counts, percentages)
- Any judgment calls or rationale

## Output Contract (What Orb Weaver Produces)

Orb Weaver will produce one SQL patch file per patch_id. Output must be fully executable SQL.

### Mandatory Output Format (Non-Negotiable)

Every patch MUST conform to the following structure exactly. Deviations are considered contract drift.

#### 1) Patch Header (Required)
The patch begins with a single header block:

/*
Patch: 000X_<zone>_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: <zone_id> (<Zone Name>)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16;<zone_id>;0
*/

Notes:
- The Contract section is not repeated inside the patch header. This protocol document is the contract.
- No additional header fields will be added (keep it minimal and stable).

#### 2) Per-Item Block (Required for every item touched)

For each item_id appearing in the patch, Orb Weaver will emit:

/* ---------------------------------------------------------------------
   Item: <item_id> - <Item Name>
   Source: https://www.wowhead.com/classic/item=<item_id>/<slug>
   Notes:
   - <Only include if needed: off-zone cleanup, magnitude delta rule, pacing override, contradictions>
   --------------------------------------------------------------------- */

Notes are omitted for straightforward policy-derived updates. They exist only to document exceptions or non-obvious decisions.

Then statements grouped with clear separators:

/* UPDATEs */
<one UPDATE with entry IN (...) OR multiple UPDATEs, but all explicitly targeted by (entry, item_id)>

/* DELETEs */
<one DELETE with entry IN (...) OR multiple DELETEs, but all explicitly targeted by (entry, item_id)>

#### 3) Targeting and Semantics (Required)

- UPDATE and DELETE always target by (entry, item_id).
- DELETE means DELETE FROM creature_loot_template. Chance is not set to 0.
- UPDATE sets ChanceOrQuestChance = new_value verbatim. Sign is meaningful.
- Statements may be grouped using entry IN (...) for readability, but must remain unambiguous and explicit.
- Idempotent behavior (safe to re-run)

## Post-Apply Validation
- Orb Weaver will suggest a validation query.
- The expected result of that query will be explicitly stated.

## Backup and Safety Model
- The WORLD database is backed up before each batch of changes.
- Database restores are destructive and authoritative.
- SQL patch files are the long-term source of truth.

## Long-Term Assumptions
- This process will be repeated many times.
- Future-you will not remember the original context.
- Documentation favors clarity over brevity.
- Speed is achieved through structure, not shortcuts.

## How to Resume Work in the Future
To resume after a long break:

1. Paste this document into a new conversation.
2. Provide the next input table.
3. State the `patch_id` and the item(s) being addressed.

No re-explanation is required.

