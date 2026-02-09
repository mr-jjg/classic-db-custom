/*
Patch: 0021_searing_gorge_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 51 (Searing Gorge)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;51:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 11818 - Grimesilt Outhouse Key
   Source: https://www.wowhead.com/classic/item=11818/grimesilt-outhouse-key
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 7
WHERE item = 11818
  AND entry IN (8566, 5840, 5844, 5846, 8504);

/* INSERTs */
INSERT INTO creature_loot_template
(entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
SELECT 15692, 11818, 7, 0, 1, 1, 0, 'Grimesilt Outhouse Key'
WHERE NOT EXISTS (
  SELECT 1
  FROM creature_loot_template
  WHERE entry = 15692
    AND item = 11818
);



/* ---------------------------------------------------------------------
   Item: 10509 - Heart of Flame
   Source: https://www.wowhead.com/classic/item=10509/heart-of-flame
   --------------------------------------------------------------------- */

/* INSERTs */
INSERT INTO creature_loot_template
(entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
SELECT 8281, 10509, -26, 0, 1, 1, 0, 'Heart of Flame'
WHERE NOT EXISTS (
  SELECT 1
  FROM creature_loot_template
  WHERE entry = 8281
    AND item = 10509
);



/* ---------------------------------------------------------------------
Item: 18960 - Lookout's Spyglass
Source: https://www.wowhead.com/classic/item=18960/lookouts-spyglass
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -20
WHERE item = 18960
AND entry IN (8566);



/* ---------------------------------------------------------------------
   Item: 10458 - Prayer to Elune
   Source: https://www.wowhead.com/classic/item=10458/prayer-to-elune
   Notes:
   - Magnitude delta collapse from guaranteed (-100) to telemetry-informed
     distribution (~4–7% observed across elite Twilight mobs).
   - Policy transform: ceil(288/4384)=7 → +1 = 8; pacing compensation +5 → 13%.
   - More closely aligns with player reports: typically a handful
     to a few dozen kills, not a guaranteed first-drop item.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -13
WHERE item = 10458
  AND entry IN (8419, 5862, 5860, 5861);



/* ---------------------------------------------------------------------
Item: 18959 - Smithing Tuyere
Source: https://www.wowhead.com/classic/item=18959/smithing-tuyere
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -20
WHERE item = 18959
AND entry IN (5840);



/* --------------------------------------------------------------------------
   Item: 11725 - Solid Crystal Leg Shaft
   Quest: Ledger from Tanaris
   Source: https://www.wowhead.com/classic/item=11725/solid-crystal-leg-shaft
   Notes:
   - Magnitude delta collapse: upstream -80 vs Wowhead telemetry ~34% per-kill occurrence.
   - Policy-derived new_val: next_multiple_of_10(34) = 40.
   - No punish compensation applied; large telemetry sample and stacked drops (1–4)
     already produce natural variance and pacing.
-------------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE entry = 5856
  AND item = 11725;



/* --------------------------------------------------------------------------
   Item: 10552 - Symbol of Ragnaros
   Quest: 3452 - The Flame's Casing
   Source: https://www.wowhead.com/classic/item=10552/symbol-of-ragnaros
   Notes:
   - Magnitude delta collapse: upstream is effectively guaranteed (-100%) across all listed Twilight elites.
   - Wowhead telemetry across the four elites clusters roughly in the ~5–16% range, with player reports
     more commonly describing completion in ~5–10 kills rather than 40–100 (long-tail variance/noise).
   - Derived new_val is set to 20% per contract rounding rules, then a +10 pacing compensation is applied
     to keep quest pacing in a “few kills” band consistent with typical player experience for a single
     elite-drop objective.
   - Normalized across all four eligible elites to avoid subtype targeting.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 10552
  AND entry IN (5860, 5861, 5862, 8419);



/* ---------------------------------------------------------------------
   Item: 10551 - Thorium Plated Dagger
   Source: https://www.wowhead.com/classic/item=10551/thorium-plated-dagger
   Notes:
   - Telemetry rates cluster for most surface dwarves, while Slave Workers stand out as materially higher.
   - Upstream is a magnitude-delta outlier at 80% across the board; collapse to a derived baseline using the standard
     new_val model, then apply punish compensation (+10) to avoid feast-or-famine pacing on an 8x collectible.
   - Kept a small differentiator for Slave Worker (40%) to preserve the only strong signal in the telemetry (they’re
     plausibly “best farming target” inside the Cauldron), while normalizing the rest to 30% to remove bogus targeting.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE entry = 5843
  AND item = 10551;

UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 10551
  AND entry IN (5840, 8566, 5844, 5846, 5839, 8504, 8637, 8337);

/* INSERTs */
INSERT INTO creature_loot_template
  (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
SELECT 15692, 10551, -30, 0, 1, 1, 0, 'Thorium Plated Dagger'
WHERE NOT EXISTS (
  SELECT 1
  FROM creature_loot_template
  WHERE entry = 15692
    AND item = 10551
);
