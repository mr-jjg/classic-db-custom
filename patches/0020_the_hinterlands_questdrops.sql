/*
Patch: 0020_the_hinterlands_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 47 (The Hinterlands)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;47:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 8704 - OOX-09/HL Distress Beacon
   Source: https://www.wowhead.com/classic/item=8704/oox-09-hl-distress-beacon
   Notes:
   - Telemetry outlier on Vile Priestess Hexx is population-stable and far above the baseline beacon world-drop model; round to 70% for this single named elite while leaving all other droppers at 1%.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 70
WHERE item = 8704
AND entry IN (7995);

