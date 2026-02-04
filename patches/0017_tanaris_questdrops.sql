/*
Patch: 0017_tanaris_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 72 (Tanaris)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;440:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 8587 - Centipaar Insect Parts
   Source: https://www.wowhead.com/classic/item=8587/centipaar-insect-parts
   Notes:
   - Wowhead NPC telemetry for Stinger/Wasp/Swarmer clusters ~38–39%, 
     and era comments repeatedly describe a “high but not 100%” rate.
   - Apply policy-derived new_val = -40 to the three upstream -20 rows.
   - Leave existing -50 rows unchanged (no normalization downward).
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 8587
  AND entry IN (5455, 5456, 5457);



/* ---------------------------------------------------------------------
   Item: 8428 - Laden Dew Gland
   Source: https://www.wowhead.com/classic/item=8428/laden-dew-gland
   Notes:
   - Only drops from Thistleshrub Dew Collector (entry 5481) per primary source targeting.
   - Player-reported “awful” experiences are not supported by the telemetry sample size 
     and are plausibly driven by killing non-droppers or low sample variance.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 8428
  AND entry IN (5481);



/* ---------------------------------------------------------------------
   Item: 6257 - Roc Gizzard
   Source: https://www.wowhead.com/classic/item=6257/roc-gizzard
   Notes:
   - Wowhead telemetry indicates ~11–12% across all Tanaris roc variants.
   - Upstream value (-75) is a high-value outlier; corrected under the magnitude delta rule.
   - Policy base derived from telemetry (~15%), with punish compensation applied,
     plus additional competition compensation due to shared spawns with hyenas.
   --------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 6257
  AND entry IN (5428, 5429, 5430);



/* ---------------------------------------------------------------------
   Item: 20519 - Southsea Pirate Hat
   Source: https://www.wowhead.com/classic/item=20519/southsea-pirate-hat
   Notes:
   - Upstream quest chance (-10) is not supported by Wowhead telemetry.
   - Telemetry clusters into two bands:
     * Core Southsea pirates ~34–35% → rounded to 40%.
     * Named / secondary / rare spawns ~14–30% → rounded and equalized to 30%.
   - Values derived strictly from contract rounding rules.
   - Southsea Kidnapper added to align seasonal/quest-gated spawn with same-area peers.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 20519
  AND entry IN (7855, 7856);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 20519
  AND entry IN (7858, 7857, 7883, 8203);

/* INSERTs */
INSERT INTO creature_loot_template
(entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
SELECT 15685, 20519, -30, 0, 1, 1, 0, 'Southsea Pirate Hat'
WHERE NOT EXISTS (
  SELECT 1
  FROM creature_loot_template
  WHERE entry = 15685
    AND item = 20519
);



/* ---------------------------------------------------------------------
   Item: 8483 - Wastewander Water Pouch
   Source: https://www.wowhead.com/classic/item=8483/wastewander-water-pouch
   Notes:
   - Normal drop (non-quest-conditional), so telemetry is a strong signal.
   - Wowhead rates cluster tightly (about 49–53%) across the core Wastewander mobs.
   - Contract rounding would push several rows to 60% (next_multiple_of_10), but that would be an inflationary step not supported by the observed cluster.
   - We normalize to a flat 50% as a conservative, “good enough” target rate for a ubiquitous, farmed drop.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 50
WHERE item = 8483
  AND entry IN (7883, 7805, 5623, 5618, 5617, 5616, 5615);
