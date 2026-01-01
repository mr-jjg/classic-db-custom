/*
Patch: 0008_ashenvale_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 331 (Ashenvale)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;331:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 5461 - Branch of Cenarius
   Source: https://www.wowhead.com/classic/item=5461/branch-of-cenarius
   Notes:
   - Prince Raze (10647) is a rare spawn and should not drop this quest item.
   - Quest text targets Geltharis as the sole intended source for Branch of Cenarius.
   --------------------------------------------------------------------- */

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 5461
  AND entry = 10647;



/* ---------------------------------------------------------------------
   Item: 5463 - Glowing Gem
   Source: https://www.wowhead.com/classic/item=5463/glowing-gem
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -11
WHERE item = 5463
  AND entry IN (3739, 3737, 3742, 3740);



/* ---------------------------------------------------------------------
   Item: 5366 - Glowing Soul Gem
   Source: https://www.wowhead.com/classic/item=5366/glowing-soul-gem
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 5366
  AND entry IN (3725, 3728, 3727, 3730, 3879);



/* ---------------------------------------------------------------------
   Item: 7128 - Uncloven Satyr Hoof
   Source: https://www.wowhead.com/classic/item=7128/uncloven-satyr-hoof
   Notes:
   - Prince Raze (10647) is a rare satyr spawn; Wowhead indicates it can drop this quest item.
   - Added as an eligible source to align with the broader Ashenvale satyr cohort.
   --------------------------------------------------------------------- */

/* INSERTs */
INSERT INTO creature_loot_template
(entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
SELECT 10647, 7128, -80, 0, 1, 1, 0, 'Uncloven Satyr Hoof'
WHERE NOT EXISTS (
  SELECT 1
  FROM creature_loot_template
  WHERE entry = 10647
    AND item = 7128
);

