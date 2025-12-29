/*
Patch: 0001_tirisfal_glades_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 85 (Tirisfal Glades)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;85:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 2839 - A Letter to Yvette
   Source: https://www.wowhead.com/classic/item=2839/a-letter-to-yvette
   Notes:
   - Includes explicit cleanup of one off-zone row (zone 130, entry 1770).
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 5
WHERE item = 2839
  AND entry IN (1522, 1520, 1523);

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 2839
  AND entry IN (1664, 1770, 1548, 1537, 1530, 1532);



/* ---------------------------------------------------------------------
   Item: 2858 - Darkhound Blood
   Source: https://www.wowhead.com/classic/item=2858/darkhound-blood
   Notes:
   - Remove Ravenous Darkhound (entry 1549) per zone intent and lack of corroborating drop evidence in Wowhead targets.
   --------------------------------------------------------------------- */

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 2858
  AND entry IN (1549);



/* ---------------------------------------------------------------------
   Item: 2834 - Embalming Ichor
   Source: https://www.wowhead.com/classic/item=2834/embalming-ichor
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 2834
  AND entry IN (1941, 1674);



/* ---------------------------------------------------------------------
   Item: 3162 - Notched Rib
   Source: https://www.wowhead.com/classic/item=3162/notched-rib
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 3162
  AND entry IN (1520, 1523);



/* ---------------------------------------------------------------------
   Item: 2855 - Putrid Claw
   Source: https://www.wowhead.com/classic/item=2855/putrid-claw
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 2855
  AND entry IN (1525, 1526);



/* ---------------------------------------------------------------------
   Item: 2875 - Scarlet Insignia Ring
   Source: https://www.wowhead.com/classic/item=2875/scarlet-insignia-ring
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 2875
  AND entry IN (1536);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 2875
  AND entry IN (1662, 1537);



/* ---------------------------------------------------------------------
   Item: 2859 - Vile Fin Scale
   Source: https://www.wowhead.com/classic/item=2859/vile-fin-scale
   Notes:
   - Reweight Tirisfal Vile Fin sources and remove off-zone rows (zone 130).
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 2859
  AND entry IN (1543, 1544, 1545);

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 2859
  AND entry IN (1767, 1768, 1908, 1909, 1957, 1958);
