/*
Patch: 0016_swamp_of_sorrows_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 8 (Swamp of Sorrows)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;8:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 6065 - Khadgar's Essays on Dimensional Convergence
   Quest: 1364 - Mazen's Behest
   Source: https://www.wowhead.com/classic/item=6065/khadgars-essays-on-dimensional-convergence
   Notes:
   - Policy-derived buff: raise from -5 to -9 based on observed floor (~7–8%) and
     standard quest-dilution compensation.
   - Equalized across all known droppers.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -9
WHERE item = 6065
  AND entry IN (764, 765, 766, 1081);



/* ---------------------------------------------------------------------
   Item: 6184 - Monstrous Crawler Leg
   Quest: Fresh Meat
   Source: https://www.wowhead.com/classic/item=6184/monstrous-crawler-leg
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE entry = 1088
  AND item = 6184;



/* ---------------------------------------------------------------------
   Item: 5938 - Pristine Crawler Leg
   Quest: 1258 - ... and Bugs
   Source: https://www.wowhead.com/classic/item=5938/pristine-crawler-leg
   Notes:
   - Policy-derived buff to guaranteed quest drops for both eligible mobs (Silt Crawler, Monstrous Crawler).
   - Wowhead telemetry is treated as non-authoritative here because kill samples for Monstrous Crawler
     are likely contaminated by Horde kills targeting a different quest item (Monstrous Crawler Leg),
     depressing the observed Pristine Crawler Leg rate for Alliance-only eligibility.
   - Quest text and long-running player reports consistently indicate 1-2 legs per eligible kill,
     implying 100% quest-conditional drop chance.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 5938
  AND entry IN (922, 1088);



/* ---------------------------------------------------------------------
   Item: 6168 - Sawtooth Snapper Claw
   Quest: 699 - Lack of Surplus
   Source: https://www.wowhead.com/classic/item=6168/sawtooth-snapper-claw
   Notes:
   - Magnitude delta collapse from upstream -80 toward observed telemetry (~21%).
   - Punish compensation applied to reduce long-tail streakiness on a 6-item
     collection quest.
   - Wowhead telemetry likely depressed by cross-quest kill contamination.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE entry = 1087
  AND item = 6168;



/* ---------------------------------------------------------------------
   Item: 5803 - Speck of Dream Dust
   Quest: 1116 - Dream Dust in the Swamp
   Zone: Swamp of Sorrows
   Source: https://www.wowhead.com/classic/item=5803/speck-of-dream-dust#dropped-by
   Notes:
   - Player reports vary widely, but multiple concrete anecdotes land around
     10 dust in ~20-35 kills, implying roughly 30% to 50% effective experience.
   - Wowhead telemetry for primary dragonkin sources is much higher (low 50s
     up through mid 60s), suggesting upstream values are under-tuned.
   - Telemetry is treated as the primary signal; player reports are interpreted
     as distorted by competition, spawn pressure, and target selection.
   - Wyrmkin Dreamwalker as a drop source is not supported by the provided
     telemetry set and not reinforced by player guidance in comments.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 5803
  AND entry IN (740, 741, 742, 744, 745, 746, 14445);

/* DELETEs */
DELETE FROM creature_loot_template
WHERE entry = 743
  AND item  = 5803;
