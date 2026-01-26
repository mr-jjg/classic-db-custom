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
   - Original upstream values were predominantly -80 and one -100.
   - Policy-derived values were adjusted upward via punish compensation
     to avoid excessive grind after magnitude collapse.
   - Rates are tiered by mob difficulty and rarity, preserving progression
     while reducing punitive variance.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 5030
  AND entry = 3272;

UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 5030
  AND entry IN (3273, 5837, 3394);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5030
  AND entry IN (3274, 3275, 3397, 5838, 3395, 5841);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 5030
  AND entry IN (9523, 9524, 9456, 3396);



/* ---------------------------------------------------------------------
   Item: 5092 - Charred Razormane Wand
   Source: https://www.wowhead.com/classic/item=5092/charred-razormane-wand
   Notes:
   - Normal drop (non-quest-conditional).
   - Telemetry directly reflects true drop chance.
   - Value set to ceil(telemetry), no normalization applied.
--------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = 26
WHERE entry = 3458 AND item = 5092;



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
   - Magnitude delta correction: upstream quest drop value (-80) collapses
     sharply relative to large-sample Classic telemetry (~25–33%).
   - Pacing compensation applied to prevent punitive grind regression after
     normalization; value set above pure policy-derived floor.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
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
   - Magnitude delta correction: upstream quest drop value (-80) collapses
     relative to large-sample Classic telemetry (~16–22% across Kodo variants).
   - Punish compensation (+10) applied to prevent punitive grind following
     normalization from legacy values.
   - Additional competition compensation applied due to wandering spawn
     behavior and dilution by other non-dropping Barrens mobs encountered
     during traversal.
   - Drop rates equalized across all Kodo types (including named and rare)
     to avoid incentivizing specific targeting.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
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
SET ChanceOrQuestChance = -40
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
   Item: 5093 - Razormane Backstabber
   Source: https://www.wowhead.com/classic/item=5093/razormane-backstabber
   Notes:
   - Normal drop from multiple NPCs.
   - Telemetry directly reflects true drop chance.
   - Values set to ceil(telemetry), no normalization applied.
--------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = 27
WHERE entry = 3457 AND item = 5093;

UPDATE creature_loot_template
SET ChanceOrQuestChance = 28
WHERE entry = 3456 AND item = 5093;



/* ---------------------------------------------------------------------
   Item: 5094 - Razormane War Shield
   Source: https://www.wowhead.com/classic/item=5094/razormane-war-shield
   Notes:
   - Normal drop (non-quest-conditional).
   - Telemetry directly reflects true drop chance.
   - Value set to ceil(telemetry), no normalization applied.
--------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = 26
WHERE entry = 3459 AND item = 5094;



/* ---------------------------------------------------------------------
   Item: 5165 - Sunscale Feather
   Source: https://www.wowhead.com/classic/item=5165/sunscale-feather
   Notes:
   - Magnitude delta correction applied (baseline -80 normalized).
   - Quest requires only 3 feathers; intended completion is immediate once
     the correct raptor variants are targeted.
   - Equalized across Sunscale Lashtail / Screecher / Scytheclaw to prevent
     punitive variance from wrong-target kills.
   - Punish compensation (+10) applied after normalization, resulting in -40.
   - No competition compensation applied; observed friction is primarily
     density/traffic near nests rather than shared spawn-pool dilution.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5165
  AND entry IN (3254, 3255, 3256);



/* ---------------------------------------------------------------------
   Item: 5143 - Thunder Lizard Blood
   Source: https://www.wowhead.com/classic/item=5143/thunder-lizard-blood
   Notes:
   - Legacy value (-80) overstates observed drop frequency.
   - Player telemetry consistently indicates ~40–50% effective drop rate,
     with typical completion in 3–6 kills.
   - Normalized under the magnitude delta rule to align quest pacing with
     empirical experience.
   - No competition compensation applied: targets are abundant, quest-focused,
     and evenly distributed across multiple subtypes.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5143
  AND entry IN (3238, 3239, 3240);



/* ---------------------------------------------------------------------
   Item: 4897 - Thunderhawk Saliva Gland
   Source: https://www.wowhead.com/classic/item=4897/thunderhawk-saliva-gland
   Notes:
   - Magnitude delta correction: upstream quest drop value (-80) collapses
     relative to Classic telemetry (~17%) for Greater Thunderhawks.
   - Punish compensation (+10) applied following normalization.
   - Light competition compensation applied due to consistent co-location
     with Stormhides and other non-dropping mobs that increase effective
     grind time without contributing to quest progress.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -35
WHERE item = 4897
  AND entry = 3249;



/* ---------------------------------------------------------------------
   Item: 5086 - Zhevra Hooves
   Source: https://www.wowhead.com/classic/item=5086/zhevra-hooves
   Notes:
   - Quest target for a level 13 Barrens quest with primary drops from
     Zhevra Runners (13–14), which show ~30% telemetry presence.
   - Legacy values (-80) exceed observed player experience and telemetry.
   - Magnitude delta collapse applied to normalize excessive quest chance.
   - Set to -40 to align with runner-dominant drop behavior while preserving
     expected early-game grind and variance.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5086
  AND entry IN (3242, 3426, 3466, 5831);
