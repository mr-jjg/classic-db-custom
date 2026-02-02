/*
Patch: 0014_dustwallow_marsh_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 15 (Dustwallow Marsh)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;15:1;0:0#0+1+19
*/



/* --------------------------------------------------------------------------
   Item: 5959 - Acidic Venom Sac
   Source: https://www.wowhead.com/classic/item=5959/acidic-venom-sac
   Notes:
   - Quest text is explicit: venom from Darkfang spiders in the marsh.
   - Wowhead telemetry supports Darkfang droppers clustering around ~22% to ~27%.
   - Equalized across all intended Darkfang droppers to avoid mob targeting.
   - Removed Darkmist spiders as droppers to match quest intent and prevent cross-family contamination.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 5959
  AND entry IN (4411, 4412, 4413, 4414, 4415);

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 5959
  AND entry IN (4376, 4378, 4379, 4380);



/* --------------------------------------------------------------------------
   Item: 22094 - Bloodkelp
   Source: https://www.wowhead.com/classic/item=22094/bloodkelp
   Notes:
   - Straightforward policy-derived uplift from ~27–29% telemetry to -30 (quest-conditional).
   - Equalized across all Alcaz Island droppers to avoid mob targeting.
   - Low-sample named elite (Tidelord Rrurgaz) is kept aligned with the main Strashaz set.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 22094
  AND entry IN (4364, 4368, 4370, 4371, 4366, 16072);



/* --------------------------------------------------------------------------
   Item: 5883 - Forked Mudrock Tongue
   Source: https://www.wowhead.com/classic/item=5883/forked-mudrock-tongue
   Notes:
   - Quest item for “Mudrock Soup and Bugs” (needs 8).
   - Telemetry ranges from ~9% to ~28% across Mudrock variants; applied contract rounding/boosting.
   - Equalized across all known droppers in this patch to avoid encouraging mob targeting.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 5883
  AND entry IN (4396, 4397, 4398, 4399, 4400);



/* --------------------------------------------------------------------------
   Item: 5942 - Jeweled Pendant
   Source: https://www.wowhead.com/classic/item=5942/jeweled-pendant
   Notes:
   - Quest-conditional drop used in “Marg Speaks”.
   - Wowhead telemetry shows consistent ~7–10% rates across all Muckshell variants.
   - Upstream value (-5) materially underrepresents observed drop frequency.
   - Standard rounding applied and equalized across all eligible mobs to avoid
     incentivizing mob or location targeting.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -11
WHERE item = 5942
  AND entry IN (4401, 4402, 4403, 4404, 4405, 14236);



/* --------------------------------------------------------------------------
   Item: 5841 - Searing Heart
   Source: https://www.wowhead.com/classic/item=5841/searing-heart
   Notes:
   - Quest item for “Identifying the Brood” (needs 15 hearts, plus 15 tongues).
   - Wowhead telemetry shows ~35% across both droppers; applying contract derive value (-40).
   - Equalized across both known droppers to avoid encouraging mob targeting.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5841
  AND entry IN (4324, 4323);



/* --------------------------------------------------------------------------
   Item: 5840 - Searing Tongue
   Source: https://www.wowhead.com/classic/item=5840/searing-tongue
   Notes:
   - Quest item for “Identifying the Brood” (needs 15).
   - Wowhead telemetry clusters around ~34–35% for both Searing Whelps and Hatchlings.
   - Comments consistently describe a long grind requiring 30 total items (hearts + tongues),
     with frequent reports of uneven drops; contract lift applies a mild normalization bump.
   - Equalized across both droppers to avoid incentivizing target switching.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5840
  AND entry IN (4323, 4324);
