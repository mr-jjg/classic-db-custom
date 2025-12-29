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
   Item: 4891 - Kron's Amulet
   Source: https://www.wowhead.com/classic/item=4891/krons-amulet
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -11
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
