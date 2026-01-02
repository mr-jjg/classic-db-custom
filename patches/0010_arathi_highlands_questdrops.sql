/*
Patch: 0010_arathi_highlands_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 45 (Arathi Highlands)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;45:1;0:0#items;0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 4450 - Sigil Fragment
   Source: https://www.wowhead.com/classic/item=4450
   Notes:
   - Magnitude delta rule: collapse from -80 to a policy-derived -40 baseline.
   - Pacing compensation (punish): +10 applied due to extreme magnitude collapse, final -50.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 4450
  AND entry IN (2583, 2584, 2585);



/* ---------------------------------------------------------------------
   Item: 4440 - Sigil of Strom
   Source: https://www.wowhead.com/classic/item=4440
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -4
WHERE item = 4440
  AND entry IN (2588, 2590, 2591);



/* ---------------------------------------------------------------------
   Item: 4506 - Stromgarde Badge
   Source: https://www.wowhead.com/classic/item=4506
   Notes:
   - Magnitude delta rule: collapse from -80 to a policy-derived ~-30 baseline.
   - Pacing compensation (punish): +10 applied due to extreme magnitude collapse, final -40.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 4506
  AND entry IN (2588, 2590, 2591);



/* ---------------------------------------------------------------------
   Item: 7273 - Witherbark Totem Stick
   Source: https://www.wowhead.com/classic/item=7273/witherbark-totem-stick
   Notes:
   - Adds rare spawn Zalas Witherbark (2605) to the existing Witherbark drop cohort at -40.
   --------------------------------------------------------------------- */

/* ADDs */
INSERT INTO creature_loot_template
  (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
SELECT
  2605, 7273, -40, 0, 1, 1, 0, 'Witherbark Totem Stick'
WHERE NOT EXISTS (
  SELECT 1
  FROM creature_loot_template
  WHERE entry = 2605
    AND item = 7273
);
