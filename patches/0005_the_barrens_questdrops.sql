/*
Patch: 0005_the_barrens_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 17 (The Barrens)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16;17;0
*/



/* ---------------------------------------------------------------------
   Item: 5098 - Altered Snapjaw Shell
   Source: https://www.wowhead.com/classic/item=5098/altered-snapjaw-shell
   Notes:
   - Historical certainty override: contemporaneous sources consistently indicate a 100% drop rate for this quest item.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 5098
  AND entry IN (3461);



/* ---------------------------------------------------------------------
   Item: 5085 - Bristleback Quilboar Tusk
   Source: https://www.wowhead.com/classic/item=5085/bristleback-quilboar-tusk
   Notes:
   - Historical certainty override: contemporaneous sources consistently indicate a 100% drop rate (1-2 per kill) for this quest item on the appropriate Bristleback mobs while the quest is active; normalize to -100 for all eligible quest mobs in this patch for consistency.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 5085
  AND entry IN (3258, 3260, 3261, 3263);



/* ---------------------------------------------------------------------
   Item: 5030 - Centaur Bracers
   Source: https://www.wowhead.com/classic/item=5030/centaur-bracers
   Notes:
   - Magnitude delta correction from pervasive -80 and one -100 upstream values.
   - Geolocation cohort smoothing applied so mobs sharing the same oasis cluster have comparable quest-drop contribution.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 5030
  AND entry IN (3272);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5030
  AND entry IN (3273, 3394, 5837);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 5030
  AND entry IN (3274, 3275, 3397, 3395, 5838, 5841);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -20
WHERE item = 5030
  AND entry IN (3396, 9456, 9523, 9524);



/* ---------------------------------------------------------------------
   Item: 5026 - Fire Tar
   Source: https://www.wowhead.com/classic/item=5026/fire-tar
   Notes:
   - Quest-conditional shaman reagent with heavily skewed telemetry due to class restriction.
   - Historical evidence supports a high but non-guaranteed drop rate; counterexamples exist across patches.
   - Normalized from -100 to -80 to preserve fast completion while retaining RNG variance.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -80
WHERE item = 5026
  AND entry IN (3267, 3268, 3269, 3271);



/* ---------------------------------------------------------------------
   Item: 5065 - Harpy Lieutenant Ring
   Source: https://www.wowhead.com/classic/item=5065/harpy-lieutenant-ring
   Notes:
   - Magnitude delta correction with Barrens pacing compensation:
     base telemetry rounding plus compensation for shared camp dilution by non-dropping harpies.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 5065
  AND entry IN (3278);



/* ---------------------------------------------------------------------
   Item: 5055 - Intact Raptor Horn
   Source: https://www.wowhead.com/classic/item=5055/intact-raptor-horn
   Notes:
   - Magnitude delta correction from inflated upstream value.
   - No additional pacing compensation applied; dense raptor-only camps allow informed routing.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5055
  AND entry IN (3256, 3257, 5842);



/* ---------------------------------------------------------------------
   Item: 15852 - Kodo Horn
   Source: https://www.wowhead.com/classic/item=15852/kodo-horn
   Notes:
   - Historical certainty override: contemporaneous Classic-era sources consistently indicate a 100% drop rate for this class-quest item.
   - Quest design intent uses mob availability and respawn pacing as the limiter, not RNG.
   - Normalized to -100 for all eligible Kodo entries in The Barrens.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 15852
  AND entry IN (3234, 3236);



/* ---------------------------------------------------------------------
   Item: 4896 - Kodo Liver
   Source: https://www.wowhead.com/classic/item=4896/kodo-liver
   Notes:
   - Magnitude delta correction with maximum Barrens pacing compensation.
   - Kodos are low-density roaming mobs with no fixed camps; availability, not RNG, is the primary constraint.
   - Ceiling applied to prevent punitive grind after normalization.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 4896
  AND entry IN (3234, 3235, 3236, 3237, 3474, 5827);



/* ---------------------------------------------------------------------
   Item: 5087 - Plainstrider Beak
   Source: https://www.wowhead.com/classic/item=5087/plainstrider-beak
   Notes:
   - Magnitude delta correction applied: upstream value (-80) substantially exceeds policy-derived rate given dense mob availability.
   - Minimal pacing compensation required due to extremely high plainstrider density across The Barrens.
   - Normalized across all eligible plainstrider variants to avoid mob targeting.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 5087
  AND entry IN (3244, 3245, 3246);



/* ---------------------------------------------------------------------
   Item: 5096 - Prowler Claws
   Source: https://www.wowhead.com/classic/item=5096/prowler-claws
   Notes:
   - Historical certainty override: multiple contemporaneous sources report a 100% drop rate.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 5096
  AND entry IN (3425);



/* ---------------------------------------------------------------------
   Item: 5062 - Raptor Head
   Source: https://www.wowhead.com/classic/item=5062/raptor-head
   Notes:
   - Historical certainty override: extensive player reports indicate 100% quest-drop behavior.
   - Telemetry variance is treated as quest-inactive distortion for higher-tier raptor kills.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 5062
  AND entry IN (3254, 3255, 3256, 3257, 5842);



/* ---------------------------------------------------------------------
   Item: 5165 - Sunscale Feather
   Source: https://www.wowhead.com/classic/item=5165/sunscale-feather
   Notes:
   - Magnitude delta correction applied: upstream value (-80) exceeds observed quest pacing for a low-count collection item.
   - Feathers are not guaranteed drops; player reports indicate variable outcomes, including dry streaks.
   - Moderate pacing compensation applied due to localized spawn clustering and incidental competition near nest areas.
   - Normalized across all Sunscale raptor variants to avoid mob targeting.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 5165
  AND entry IN (3254, 3255, 3256);



/* ---------------------------------------------------------------------
   Item: 5143 - Thunder Lizard Blood
   Source: https://www.wowhead.com/classic/item=5143/thunder-lizard-blood
   Notes:
   - Barrens pacing adjustment informed by player reports of moderate drop rates with significant variance.
   - Subtypes are tiered slightly to reflect recurring claims that higher-level variants drop more often, while keeping overall quest flow smooth.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -35
WHERE item = 5143
  AND entry IN (3240);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5143
  AND entry IN (3239);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -45
WHERE item = 5143
  AND entry IN (3238);



/* ---------------------------------------------------------------------
   Item: 4897 - Thunderhawk Saliva Gland
   Source: https://www.wowhead.com/classic/item=4897/thunderhawk-saliva-gland
   Notes:
   - Telemetry-derived base chance ~17%, rounded to 20% per policy.
   - Pacing compensation applied due to magnitude collapse from -80
     and mixed spawn competition in the southern Barrens.
   - Final value reflects +10 collapse compensation and +10 competition
     compensation for non-quest mobs sharing the area.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 4897
  AND entry = 3249;



/* ---------------------------------------------------------------------
   Item: 5086 - Zhevra Hooves
   Source: https://www.wowhead.com/classic/item=5086/zhevra-hooves
   Notes:
   - Family-wide normalization: higher-level and rare entries retained for consistency, but tuned to match early quest flow.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 5086
  AND entry IN (3242, 3426, 3466, 5831);
