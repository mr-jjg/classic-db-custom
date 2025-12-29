/*
Patch: 0003_mulgore_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 215 (Mulgore)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16;215;0
*/



/* ---------------------------------------------------------------------
   Item: 4752 - Azure Feather
   Source: https://www.wowhead.com/classic/item=4752/azure-feather
   Notes:
   - Telemetry-derived lower bound ≈ 45%, rounded to -50 per policy.
   - Existing DB value was -80; reduction qualifies under magnitude delta rule.
   - Pacing compensation applied (+10) due to collapse from high upstream magnitude
     in a multi-item quest (6 Azure + 6 Bronze).
   - Without compensation, expected total kills for the quest increase from ~15
     to ~27; with compensation, expected kills are ~22.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 4752
  AND entry = 2964;



/* ---------------------------------------------------------------------
   Item: 4753 - Bronze Feather
   Source: https://www.wowhead.com/classic/item=4753/bronze-feather
   Notes:
   - Telemetry-derived lower bound ≈ 40%, rounded to -40 per policy.
   - Existing DB value was -80; reduction qualifies under magnitude delta rule.
   - Pacing compensation applied (+10) due to collapse from high upstream magnitude
     in a multi-item quest (6 Azure + 6 Bronze).
   - Compensation preserves quest pacing consistency while retaining
     telemetry-informed asymmetry between feather types.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 4753
  AND entry = 2965;



/* ---------------------------------------------------------------------
   Item: 4805 - Flatland Cougar Femur
   Source: https://www.wowhead.com/classic/item=4805/flatland-cougar-femur
   Notes: Mazzranache pacing normalization to -15
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 4805
  AND entry = 3035;



/* ---------------------------------------------------------------------
   Item: 4740 - Plainstrider Feather
   Source: https://www.wowhead.com/classic/item=4740/plainstrider-feather
   Notes:
   - Telemetry-derived lower bound ≈ 47%, rounded to -50 per policy.
   - Existing DB value was -80; reduction qualifies under magnitude delta rule.
   - Pacing compensation applied (+10) due to collapse from high upstream magnitude
     in a starter quest requiring 7 Feathers and 7 Meat.
   - Compensation preserves expected starter quest completion (~13 kills)
     while remaining within -60 guardrail.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 4740
  AND entry = 2955;



/* ---------------------------------------------------------------------
   Item: 4739 - Plainstrider Meat
   Source: https://www.wowhead.com/classic/item=4739/plainstrider-meat
   Notes:
   - Companion quest item to Plainstrider Feather; both may drop on the same kill,
     so compensation is applied symmetrically to preserve early-zone pacing.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 4739
  AND entry = 2955;



/* ---------------------------------------------------------------------
   Item: 4806 - Plainstrider Scale
   Source: https://www.wowhead.com/classic/item=4806/plainstrider-scale
   Notes:
   - Mazzranache pacing normalization to -15
   - Off-scope and unintended droppers removed to keep the quest localized to Mulgore
     and avoid early-area or cross-zone completion.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 4806
  AND entry IN (2956, 2957, 3068);

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 4806
  AND entry IN (2955, 3244, 3245, 3246);



/* ---------------------------------------------------------------------
   Item: 4759 - Plainstrider Talon
   Source: https://www.wowhead.com/classic/item=4759/plainstrider-talon
   Notes:
   - Off-scope and unintended droppers removed to keep the quest localized to Mulgore.
   --------------------------------------------------------------------- */

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 4759
  AND entry IN (2955, 3244, 3245, 3246);



/* ---------------------------------------------------------------------
   Item: 4804 - Prairie Wolf Heart
   Source: https://www.wowhead.com/classic/item=4804/prairie-wolf-heart
   Notes: Mazzranache pacing normalization to -15
   --------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 4804
  AND entry IN (2958, 2959, 2960);



/* ---------------------------------------------------------------------
   Item: 4702 - Prospector's Pick
   Source: https://www.wowhead.com/classic/item=4702/prospectors-pick
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 4702
  AND entry = 2989;

UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 4702
  AND entry = 2990;



/* ---------------------------------------------------------------------
   Item: 4807 - Swoop Gizzard
   Source: https://www.wowhead.com/classic/item=4807/swoop-gizzard
   Bundle: Mazzranache pacing normalization to -15
   --------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 4807
  AND entry IN (2969, 2970, 2971);



/* ---------------------------------------------------------------------
   Item: 4769 - Trophy Swoop Quill
   Source: https://www.wowhead.com/classic/item=4769/trophy-swoop-quill
   Notes:
   - Taloned Swoop retained as a dropper based on corroborating reports and existing DB presence; normalized to -50 for quest parity.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -90
WHERE item = 4769
  AND entry = 2969;

UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 4769
  AND entry IN (2970, 2971);



/* ---------------------------------------------------------------------
   Item: 4751 - Windfury Talon
   Source: https://www.wowhead.com/classic/item=4751/windfury-talon
   Notes:
   - Reduced from -80 to -60 based on Wowhead telemetry (51–52%).
   - Policy-derived normalization; no exception or pacing compensation applied.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 4751
  AND entry IN (2962, 2963);
