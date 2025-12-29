/*
Patch: 0006_stonetalon_mountains_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 406 (Stonetalon Mountains)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;406:1;0:0
*/



/* ---------------------------------------------------------------------
   Item: 6839 - Charred Horn
   Source: https://www.wowhead.com/classic/item=6839/charred-horn
   Notes:
   - Historical evidence supports a guaranteed drop with variable stack size (1–3) from eligible chimaeras.
   - Player reports consistently indicate horn acquisition reliability; difficulty arises from spawn density and encounter danger, not RNG failure.
   - Normalized to 100% drop rate to accurately encode guaranteed-behavior semantics while retaining variable quantity.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 6839
  AND entry IN (4031, 4032);



/* ---------------------------------------------------------------------
   Item: 5585 - Courser Eye
   Source: https://www.wowhead.com/classic/item=5585/courser-eye
   Notes:
   - Historical evidence consistently indicates a guaranteed drop.
   - Each eligible courser drops exactly two eyes per kill.
   - Normalized to 100% drop rate with fixed quantity (2) to reflect original Vanilla behavior.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 5585
  AND entry IN (4018, 4019);



/* ---------------------------------------------------------------------
   Item: 5675 - Crystalized Scales
   Source: https://www.wowhead.com/classic/item=5675/crystalized-scales
   Notes:
   - Drop rate normalized upward based on consistent player reports indicating approximately 25–35% success per kill.
   - Adjusted to reduce punitive RNG while preserving intended pacing driven by basilisk spawn density and zone traversal.
   - Applied uniformly across Stonetalon and Shimmering Flats basilisk variants for consistency and to avoid mob targeting.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 5675
  AND entry IN (4044, 4041, 4042, 4147);



/* ---------------------------------------------------------------------
   Item: 5583 - Fey Dragon Scale
   Source: https://www.wowhead.com/classic/item=5583/fey-dragon-scale
   Notes:
   - Quest item for "Jin'Zil's Forest Magic".
   - Verified 100% drop rate (1 per kill) across Fey Dragon variants.
   - Consistent with Vanilla and Classic-era player reports.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 5583
  AND entry IN (4016, 4017, 4066);



/* ---------------------------------------------------------------------
   Item: 6840 - Galvanized Horn
   Source: https://www.wowhead.com/classic/item=6840/galvanized-horn
   Notes:
   - Quest item for the Warrior Brutal Armor chain (Stonetalon Mountains).
   - Dropped by the Chimaera Matriarch.
   - Historical evidence supports a guaranteed drop upon killing the correct quest NPC.
   - Normalized to 100% drop rate to reflect deterministic quest completion behavior.
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 6840
  AND entry = 6167;



/* ---------------------------------------------------------------------
   Item: 16312 - Incendrites
   Source: https://www.wowhead.com/classic/item=16312/incendrites
   Notes:
   - Quest item for "Elemental War" (Stonetalon Mountains).
   - Historical player reports consistently indicate a guaranteed drop when the quest is active.
   - Difficulty arises from low spawn density and shared spawn timers, not RNG failure.
   - Normalized to 100% drop rate to reflect deterministic quest behavior.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 16312
  AND entry IN (4036, 4037, 4038);



/* ---------------------------------------------------------------------
   Item: 16581 - Resonite Crystal
   Source: https://www.wowhead.com/classic/item=16581/resonite-crystal
   Notes:
   - Not a creature drop, but collected from world objects.
   --------------------------------------------------------------------- */

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 16581
  AND entry IN (11915, 11917, 11918);



/* ---------------------------------------------------------------------
   Item: 5582 - Stonetalon Sap
   Source: https://www.wowhead.com/classic/item=5582/stonetalon-sap
   Notes:
   - Magnitude delta normalization applied from legacy -80 values.
   - Adjusted to -60 to reduce punitive RNG while preserving the historically frustrating nature of the quest.
   - No additional competition compensation applied; restricted eligible mobs and spawn confusion already contribute to difficulty.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 5582
  AND entry = 4020;



/* ---------------------------------------------------------------------
   Item: 5734 - Super Reaper 6000 Blueprints
   Source: https://www.wowhead.com/classic/item=5734/super-reaper-6000-blueprints
   Notes:
   - Magnitude delta correction from -100 baseline.
   - Normalized to -30, with a +10 local pacing offset for concentrated Operator farming loops.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5734
  AND entry = 3988;



/* ---------------------------------------------------------------------
   Item: 5584 - Twilight Whisker
   Source: https://www.wowhead.com/classic/item=5584/twilight-whisker
   Quest: Jin'Zil's Forest Magic
   Notes:
   - Legacy DB value (-80) is punitive relative to player reports and mob density.
   - Community data indicates highly variable but non-trivial drop rate, commonly
     reported between ~20–35% with clustering effects.
   - Twilight Runners are tightly clustered in Stonetalon Peak, enabling efficient
     farming despite variance.
   - Adjusted under magnitude delta normalization to a moderate rate (-50),
     consistent with other Jinzil quest components and pacing expectations.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 5584
  AND entry = 4067;
