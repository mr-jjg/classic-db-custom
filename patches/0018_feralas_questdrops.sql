/*
Patch: 0018_feralas_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 357 (Feralas)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:357;440:1;0:0#0+1+19
*/




/* ---------------------------------------------------------------------
   Item: 9589 - Encrusted Minerals
   Source: https://www.wowhead.com/classic/item=9589/encrusted-minerals
   Notes:
   - Magnitude delta collapse: upstream is -80 across all droppers, normalized to policy-derived value of -40.
   - No punish compensation applied: the policy-derived result is already -40 
     (not a punitive collapse into the -20/-30 band), and the quest only requires 6 minerals.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 9589
  AND entry IN (7997, 5278, 5276, 5358, 5357, 14604, 14640);



/* ---------------------------------------------------------------------
   Item: 9371 - Gordunni Orb
   Quest: The Gordunni Orb
   Source: https://www.wowhead.com/classic/item=9371/gordunni-orb
   Notes:
   - Magnitude delta correction: upstream quest drop value (-100) is not
     consistent with player-reported experience and is treated as a legacy
     over-guarantee rather than an intentional 100% design.
   - Wowhead telemetry (~16%) is strongly deflated due to quest-conditional
     eligibility, heavy non-quest kills, and faction-based dilution, and is
     therefore not suitable as a direct tuning anchor.
   - Pacing compensation applied up to the contract cap: normalized to -50
     to preserve the intended “few kills” experience for this non-gated,
     segway-style quest step without exceeding compensation limits.
--------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 9371
  AND entry = 5239;



/* ---------------------------------------------------------------------
   Item: 9460 - Grimtotem Horn
   Quest: A Grim Discovery
   Source: https://www.wowhead.com/classic/item=9460/grimtotem-horn
   Notes:
   - Magnitude delta collapse: upstream quest drop value (-80) normalized to
     a policy-derived baseline informed by large-sample Classic telemetry
     (~40–46% across Grimtotem variants).
   - Pacing compensation applied within contract cap: adjusted upward to -60
     to preserve the historically “very fast” completion experience for this
     20-item quest while avoiding excessive over-guarantee.
   - Drop rates equalized across all Grimtotem variants; multi-drop behavior
     (min 1 / max 2) preserved to reflect consistent player reports of
     multiple horns per kill.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 9460
  AND entry IN (7727, 7725, 7726);



/* --------------------------------------------------------------------------
   Item: 9247 - Hatecrest Naga Scale
   Quest: Against the Hatecrest
   Source: Wowhead NPC telemetry + contract equalization policy
   Notes:
   - Screamer and Warrior entries were elevated above peer naga types without
     strong telemetry support.
   - Large-sample Classic telemetry clusters common naga droppers around ~36–38%.
   - Equalized to 40% to remove targeting incentives and align with existing
     baseline values already present on the majority of entries.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 9247
  AND entry IN (5335, 5331);



/* ---------------------------------------------------------------------
   Item: 9369 - Iridescent Sprite Darter Wing
   Source: https://www.wowhead.com/classic/item=9369/iridescent-sprite-darter-wing
   Notes:
   - Contract-derived from Wowhead telemetry (~40-41%) using rounding rules; equalized
     across droppers to avoid targeting incentives.
   - Interpretive principle applied: player comments consistently describe near-constant
     drops and frequent multi-yield kills ("almost perfect," "1–3 at a time," rapid
     completion), justifying deviation above the default rounded new_val.
   - Normalized Captured Sprite Darter to maxcount=2 to match expected wing yield behavior.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60,
    maxcount = 2
WHERE item = 9369
  AND entry IN (5278, 7997);



/* ---------------------------------------------------------------------
   Item: 6258 - Ironfur Liver
   Quest: Rhapsody's Kalimdor Kocktail
   Source: https://www.wowhead.com/classic/item=6258/ironfur-liver
   Notes:
   - Magnitude delta collapse: legacy values (-75 / -75 / -15) normalized to a
     telemetry-informed baseline (~10–16% observed across Ironfur variants).
   - Pacing compensation applied within contract cap: raised to -30 to preserve
     intended quick collection for a 3-item quest step and align with sibling
     Groddoc Liver tuning.
   - Equalized across all Ironfur variants to remove targeting incentives.
   - Rare spawn (Old Grizzlegut) included for consistency with species-level
     drop behavior.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 6258
  AND entry IN (5274, 5272, 5268);

/* INSERTs */
INSERT INTO creature_loot_template
(entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
SELECT 5352, 6258, -30, 0, 1, 1, 0, 'Ironfur Liver'
WHERE NOT EXISTS (
  SELECT 1
  FROM creature_loot_template
  WHERE entry = 5352
    AND item = 6258
);



/* ---------------------------------------------------------------------
   Item: 9592 - Metallic Fragments
   Source: https://www.wowhead.com/classic/item=9592/metallic-fragments
   Notes:
   - Magnitude delta collapse from uniform upstream -80 to tiered, policy-derived values.
   - Clear and persistent stratification is supported by both telemetry and long-term player reports:
       * Frayfeather Stagwing / Patriarch / Hippogryph (and Antilus) are consistently described as
         the “feels good” farm and anchor the primary quest path.
       * Frayfeather Skystormer is repeatedly identified as a trap mob with materially worse drops.
       * Hinterlands owlbeasts are viable but secondary; wowhead telemetry is treated as a lower
         bound due to heavy non-quest kill contamination.
       * Giants (including zapped variants) are treated as an alternative route with improved
         efficiency, but not a dominant shortcut.
   - No punish compensation applied: although the collapse is large, the resulting values preserve
     the intended grind (40 required) while eliminating punitive variance from the -80 baseline.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 9592
  AND entry IN (5304, 5306, 5300, 5347);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 9592
  AND entry IN (5358, 5357, 14640, 14604);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 9592
  AND entry IN (2928, 2927, 2929, 7808, 7584);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -12
WHERE item = 9592
  AND entry = 5305;



/* ---------------------------------------------------------------------
   Item: 18947 - Rage Scar Yeti Hide
   Quest: 7733 - Improved Quality
   Source: https://www.wowhead.com/classic/item=18947/rage-scar-yeti-hide
   Notes:
   - Entry 7848 (Lurking Feral Scar) is not part of the Rage Scar Hold yeti pool and is
     associated with Thick Yeti Hide instead, so its presence in this loot template is
     treated as a cross-pool contamination.
--------------------------------------------------------------------- */

/* DELETE */
DELETE FROM creature_loot_template
WHERE entry = 7848
  AND item = 18947;



/* ---------------------------------------------------------------------
   Item: 9591 - Resilient Sinew
   Source: https://www.wowhead.com/classic/item=9591/resilient-sinew
   Notes:
   - Magnitude delta collapse from uniform upstream -80 to a single policy-derived value.
   - No durable stratification signal exists across droppers; player reports consistently
     describe sinew as a passive acquisition while farming other quest materials.
   - Wowhead telemetry variance is treated as noise due to heavy non-quest contamination,
     especially for Hinterlands owlbeasts.
   - Equalized to preserve intended pacing (20 required) without introducing trap or
     optimal-only mob behavior.
   - No punish compensation applied.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 9591
  AND entry IN (5300, 5304, 5305, 5306, 5347, 2927, 2928, 2929, 7808);



/* ---------------------------------------------------------------------
   Item: 9590 - Splintered Log
   Source: https://www.wowhead.com/classic/item=9590/splintered-log
   Notes:
   - Single-dropper quest item with long-standing player consensus of 100% drop rate.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 9590
  AND entry = 7584;



/* --------------------------------------------------------------------------
   Item: 8973 - Thick Yeti Hide
   Source: https://www.wowhead.com/classic/item=8973/thick-yeti-hide
   Notes:
   - Wowhead kill telemetry centers ~59–62% for primary Feral Scar yeti types, with
     the largest sample (Feral Scar Yeti) carrying the most statistical weight.
   - Kill-based telemetry is treated as a lower bound because dataset includes
     non-quest kills; true quest-phase rate is therefore slightly higher.
   - Skinning drops are handled in a separate skinning template and do not affect
     creature_loot_template values; kill-loot data should be evaluated independently.
   - Equalized across all droppers using the highest stable value as the anchor
     to avoid intra-camp targeting incentives.
   - Contract-derived rounding: ceil(62) → 70 tier.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -70
WHERE item = 8973
  AND entry IN (5292, 5293, 5295, 7848, 5346);
