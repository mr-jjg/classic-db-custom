/*
Patch: 0015_badlands_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 3 (Badlands)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;3:1;0:0#0+1+19
*/



/* --------------------------------------------------------------------------
   Item: 4628 - Bracers of Rock Binding
   Quest: Study of the Elements: Rock
   Source: https://www.wowhead.com/classic/item=4628/bracers-of-rock-binding
   Notes:
   - Player completion anecdotes consistently report ~5 bracers in ~15–20 kills,
     implying an effective drop rate in the ~25–35% range.
   - Wowhead telemetry (~11%) is not representative due to extreme contamination:
     these mobs are heavily farmed by non-quest level 60s for Elemental Earth,
     suppressing apparent quest drop rates.
   - Upstream DB value (-80) is an overcompensation for spawn pressure and farming;
     magnitude delta collapsed to a sane quest-conditional value.
   - Set to 30% to preserve reasonable quest pacing..
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE entry = 2736
  AND item = 4628;



/* --------------------------------------------------------------------------
   Item: 7847 - Buzzard Gizzard
   Quest: Badlands Reagent Run
   Source: https://www.wowhead.com/classic/item=7847/buzzard-gizzard
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 7847
  AND entry IN (2829, 2830, 2831);



/* --------------------------------------------------------------------------
   Item: 7846 - Crag Coyote Fang
   Quest: Badlands Reagent Run
   Source: https://www.wowhead.com/classic/item=7846/crag-coyote-fang
   Notes:
   - Wowhead telemetry for common coyotes clusters ~16–25%; rabid variant shows
     a much lower observed rate (~7%) with a small sample and location bias.
   - Equalized across all four coyote entries to avoid skew from low-traffic mobs.
   - Upstream DB value (-80) is a magnitude delta outlier; collapsed to a sane
     quest-conditional rate with punish compensation applied.
   - Set to 40% to preserve reasonable quest pacing, noting procs can yield 1–2.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 7846
  AND entry IN (2727, 2728, 2729, 2730);



/* --------------------------------------------------------------------------
   Item: 6166 - Coyote Jawbone
   Quest: Coyote Thieves
   Source: https://www.wowhead.com/classic/item=6166/coyote-jawbone
   Notes:
   - Comment consensus is effectively unanimous: “1 jawbone per coyote” and “100% drop”
     across locations and eras (with multiple explicit 100% claims).
   - Wowhead telemetry varies widely by coyote type (e.g., Elder vs Rabid), which is
     more consistent with kill/loot sampling artifacts than intended quest pacing.
   - Upstream DB value (-80) is already high; bumping to -100 aligns with the quest’s
     reputation as a straightforward 30-kill collect.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE entry IN (2727, 2728, 2729, 2730)
  AND item  = 6166;



/* --------------------------------------------------------------------------
   Item: 4519 - Crumpled Scroll Fragment
   Quest: The Lost Fragments
   Source: https://www.wowhead.com/classic/item=4519
   Notes:
   - Wowhead telemetry (~2.3%) reflects quest-conditional drop behavior across a stable,
     cross-era sample; Enraged Rock Elementals are not primary Elemental Earth farm targets,
     reducing non-quest contamination.
   - Player reports consistently describe long-tail outcomes (early fragments common,
     final fragment grindy), which is consistent with independent low single-digit rolls
     rather than staged or weighted logic.
   - Existing DB values (~33%) represented a magnitude-delta outlier relative to observed
     behavior; values are collapsed to a policy-derived rate to restore intended quest pacing
     without altering the underlying attrition-based design.
-------------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -4
WHERE entry = 2791
  AND item = 4519;



/* ---------------------------------------------------------------------
   Item: 4627 - Large Stone Slab
   Source: https://www.wowhead.com/classic/item=4627/large-stone-slab
   Notes:
   - Quest-conditional drop intended to be effectively deterministic.
   - Wowhead telemetry (~5%) is invalid due to heavy off-quest elemental farming.
   - Player reports across Vanilla and Classic overwhelmingly indicate 3/3 completion
     when killing the correct Rock Elemental entry while on the quest.
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE entry = 92
  AND item = 4627;



/* ---------------------------------------------------------------------
   Item: 7848 - Rock Elemental Shard
   Quest: 713 - Badlands Reagent Run
   Source: https://www.wowhead.com/classic/item=7848/rock-elemental-shard
   Notes:
   - Quest-conditional drop (negative sign).
   - Wowhead telemetry is heavily contaminated by off-quest farming and
     elemental-earth grinding; comments consistently indicate a materially
     higher on-quest rate than upstream DB values.
   - Player reports cluster around ~33–40%, with occasional higher outliers.
   - Equalized across all known Badlands rock elemental variants to prevent
     mob-type targeting and normalize completion time.
   - Value chosen: -40 (moderate, defensible midpoint aligned with anecdotal data).
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 7848
  AND entry IN (92, 2735, 2736, 2745, 2752, 2791, 2919, 8278);



/* ---------------------------------------------------------------------
   Item: 4630 - Scrap Metal
   Quest: 710 - Scrounging
   Source: https://www.wowhead.com/classic/item=4630/scrap-metal
   Notes:
   - Quest-conditional drop. Telemetry is diluted by off-quest kills,
     but relative ordering still suggests most Dustbelchers sit in the ~32–39% band.
   - Equalized across all known Badlands Dustbelcher droppers to eliminate targeting
     pressure between camps and subtypes.
   - Value chosen: -40 (defensible midpoint aligned with the main telemetry cluster).
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 4630
  AND entry IN (2906, 2701, 2715, 2907, 2716, 2718, 2717, 2720, 2719);



/* --------------------------------------------------------------------------
   Item: 4520 - Singed Scroll Fragment
   Quest: The Lost Fragments
   Source: https://www.wowhead.com/classic/item=4520
   Notes:
   - Wowhead telemetry (~2.3%) reflects quest-conditional drop behavior across a stable,
     cross-era sample; Enraged Rock Elementals are not primary Elemental Earth farm targets,
     reducing non-quest contamination.
   - Player reports consistently describe long-tail outcomes (early fragments common,
     final fragment grindy), which is consistent with independent low single-digit rolls
     rather than staged or weighted logic.
   - Existing DB values (~33%) represented a magnitude-delta outlier relative to observed
     behavior; values are collapsed to a policy-derived rate to restore intended quest pacing
     without altering the underlying attrition-based design.
-------------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -4
WHERE entry = 2791
  AND item = 4520;



/* --------------------------------------------------------------------------
   Item: 4518 - Torn Scroll Fragment
   Quest: The Lost Fragments
   Source: https://www.wowhead.com/classic/item=4518
   Notes:
   - Wowhead telemetry (~2.3%) reflects quest-conditional drop behavior across a stable,
     cross-era sample; Enraged Rock Elementals are not primary Elemental Earth farm targets,
     reducing non-quest contamination.
   - Player reports consistently describe long-tail outcomes (early fragments common,
     final fragment grindy), which is consistent with independent low single-digit rolls
     rather than staged or weighted logic.
   - Existing DB values (~33%) represented a magnitude-delta outlier relative to observed
     behavior; values are collapsed to a policy-derived rate to restore intended quest pacing
     without altering the underlying attrition-based design.
-------------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -4
WHERE entry = 2791
  AND item = 4518;
