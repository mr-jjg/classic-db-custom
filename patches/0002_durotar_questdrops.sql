/*
Patch: 0002_durotar_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 14 (Durotar)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16;14;0
*/



/* ---------------------------------------------------------------------
   Item: 4870 - Canvas Scraps
   Source: https://www.wowhead.com/classic/item=4870/canvas-scraps
   Notes:
   - Increases drop rate on nearby Tiragarde Keep human mobs while
     retaining higher drop rates for geographically distant centaurs.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 4870
  AND entry IN (3128, 3129);



/* ---------------------------------------------------------------------
   Item: 4888 - Crawler Mucus
   Source: https://www.wowhead.com/classic/item=4888/crawler-mucus
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 4888
  AND entry = 3106;



/* ---------------------------------------------------------------------
   Item: 4892 - Durotar Tiger Fur
   Source: https://www.wowhead.com/classic/item=4892/durotar-tiger-fur
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 4892
  AND entry = 3121;



/* ---------------------------------------------------------------------
   Item: 4887 - Intact Makrura Eye
   Source: https://www.wowhead.com/classic/item=4887/intact-makrura-eye
   Notes:
   - Removes an off-zone / wrong-level row: Slimeshell Makrura (entry 6020) is a Barrens mob (lvl 18-19),
     and should not be a quest source for this Durotar starter-area item.
   --------------------------------------------------------------------- */

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 4887
  AND entry IN (6020);



/* ---------------------------------------------------------------------
   Item: 4891 - Kron's Amulet
   Source: https://www.wowhead.com/classic/item=4891/krons-amulet
   Notes:
   - Historical reports consistently describe a low but non-exceptional
     drop rate with high perceived variance due to single-item quest design.
   - New value reflects a mechanical normalization to ~15% to reduce
     extreme outlier streaks while preserving quest pacing and intent.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 4891
  AND entry IN (3110, 3231);



/* ---------------------------------------------------------------------
   Item: 6652 - Reagent Pouch
   Source: https://www.wowhead.com/classic/item=6652/reagent-pouch
   Notes:
   - Reduced from -100 to -80 due to corroborated contradiction in player reports.
   - Comments consistently indicate very high but not guaranteed drop behavior.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -80
WHERE item = 6652
  AND entry = 3199;
