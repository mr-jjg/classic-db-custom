/*
Patch: 0011_stranglethorn_vale_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 33 (Stranglethorn Vale)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;33:1;0:0
*/



/* ---------------------------------------------------------------------
   Item: 4029 - Akiris Reed
   Source: https://www.wowhead.com/classic/item=4029/akiris-reed
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 4029
  AND entry = 1907;



/* ---------------------------------------------------------------------
   Item: 1519 - Bloodscalp Ear
   Source: https://www.wowhead.com/classic/item=1519/bloodscalp-ear
   Notes:
   - Magnitude delta rule applied (-80 → -30).
   - Pacing compensation applied (+10), final value -40.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 1519
  AND entry IN (694, 697, 587, 702, 701, 588, 595, 699, 597, 660, 671);



/* ---------------------------------------------------------------------
   Item: 3915 - Bloody Bone Necklace
   Source: https://www.wowhead.com/classic/item=3915/bloody-bone-necklace
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 3915
  AND entry IN (694, 697, 587, 702, 701, 588, 595, 699, 597, 660, 671);



/* ---------------------------------------------------------------------
   Item: 3897 - Dizzy's Eye
   Source: https://www.wowhead.com/classic/item=3897/dizzys-eye
   Notes:
   - Upstream DB enumerated only a subset of valid Bloodsail droppers.
   - Classic-era comments consistently indicate a low (~1–5%) drop rate,
     with wide variance and strong RNG perception.
   - Original value (-10) was inflated relative to evidence.
   - Normalized to -4 to align with observed telemetry while preserving
     quest pacing and grind character.
   - Pretty Boy Duncan (2545) and Ironpatch (2547) added to match historical
     drop behavior without creating special-case exploits.
   --------------------------------------------------------------------- */

/* INSERTs */
INSERT IGNORE INTO creature_loot_template
(entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
VALUES
(2545, 3897, -4, 0, 1, 1, 0, "Dizzy's Eye"),
(2547, 3897, -4, 0, 1, 1, 0, "Dizzy's Eye");

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -4
WHERE item = 3897
  AND entry IN (
      1561, 1562, 1563, 1564, 1565,
      1653,
      2546, 2548, 2549, 2550, 2551,
      4505, 4506,
      2545, 2547
  );



/* ---------------------------------------------------------------------
   Item: 4105 - Elder Crocolisk Skin
   Source: https://www.wowhead.com/classic/item=4105/elder-crocolisk-skin
   Notes:
   - Comments indicate the gate is spawning/finding the Elder croc; once killed,
     the quest item is effectively deterministic.
   - Upstream value (-80) is inconsistent with that behavior; corrected to -100.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 4105
  AND entry = 2635;



/* ---------------------------------------------------------------------
   Item: 5796 - Encrusted Tail Fin
   Source: https://www.wowhead.com/classic/item=5796/encrusted-tail-fin
   Notes:
   - Patch 1.2.1 restricted drops to elite Saltscale murlocs only.
   - Classic-era and modern comments consistently report deterministic
     drops once the correct underwater elites are killed.
   - Wowhead percentages under-report due to quest-conditional telemetry.
   - Upstream value (-80) corrected to -100 to reflect intended behavior.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 5796
  AND entry IN (877, 871, 879, 873, 875);



/* ---------------------------------------------------------------------
   Item: 2799 - Gorilla Fang
   Source: https://www.wowhead.com/classic/item=2799/gorilla-fang
   Notes:
   - Gorilla Fang is not a deterministic drop; Wowhead telemetry clusters
     around ~40–50% across gorilla variants.
   - One upstream entry (1511) was set to 100%, inconsistent with both
     telemetry and peer mobs.
   - Value normalized to 50 to align with the rest of the drop table.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 50
WHERE item = 2799
  AND entry = 1511;



/* ---------------------------------------------------------------------
   Item: 3911 - Pulsing Blue Shard
   Source: https://www.wowhead.com/classic/item=3911/pulsing-blue-shard
   Notes:
   - Classic magnitude-delta correction: upstream value (-80) is inconsistent
     with observed quest completion pacing.
   - Ironjaw Basilisks are single-purpose quest mobs located exclusively
     inside a dense cave with no competing non-quest drops.
   - Player reports consistently show high but non-deterministic yields
     (typically 3 shards in 3–10 kills), ruling out 100% while supporting
     a substantial buff.
   - Applied punish compensation (+10) after magnitude collapse to preserve
     intended pacing without eliminating RNG variance.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 3911
  AND entry = 1551;



/* ---------------------------------------------------------------------
   Item: 3838 - Shadowmaw Claw
   Source: https://www.wowhead.com/classic/item=3838/shadowmaw-claw
   Notes:
   - Extensive Vanilla (1.12.x) and Classic-era comments consistently
     indicate a deterministic (100%) drop during the quest.
   - Design intent is clear: Shadowmaw Claws are guaranteed, while
     Pristine Tigress Fang provides the RNG-based pacing.
   - Normalized to -100 to reflect deterministic behavior and avoid
     compounding grind on shared respawns.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 3838
  AND entry IN (684, 1713);



/* ---------------------------------------------------------------------
   Item: 1532 - Shrunken Head
   Source: https://www.wowhead.com/classic/item=1532/shrunken-head
   Quest: Headhunting
   Notes:
   - Quest-conditional drop from Bloodscalp Headhunters only.
   - Consistently reported as 100% drop rate with 1–3 items per kill.
   - Reports of low drop rate correlate with killing incorrect mobs
     or lacking the quest.
   - Existing min/max counts already reflect intended behavior.
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE entry = 671
  AND item = 1532;



/* ---------------------------------------------------------------------
   Item: 3917 - Singing Blue Crystal
   Source: https://www.wowhead.com/classic/item=3917/singing-blue-crystal
   Notes:
   - Upstream values are -80 across all listed Venture Co. entries.
   - Player reports indicate highly variable outcomes, including Classic-era
     anecdotes around ~20-40% effective rates and general “low / annoying” grind.
   - Apply magnitude delta normalization with pacing compensation:
       -80 -> -60 (policy target -50 plus +10 compensation)
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 3917
  AND entry IN (674, 675, 676, 677, 14492, 4723);



/* ---------------------------------------------------------------------
   Item: 3918 - Singing Crystal Shard
   Source: https://www.wowhead.com/classic/item=3918/singing-crystal-shard
   Notes:
   - Magnitude delta normalization applied (-80 → -50).
   - Comment consensus indicates frequent drops (≈ every 2nd kill),
     with fast respawn and multi-quest overlap in the area.
   - No additional pacing compensation applied.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 3918
  AND entry IN (688, 689, 690, 1550, 1551);



/* ---------------------------------------------------------------------
   Item: 2466 - Skullsplitter Fetish
   Source: https://www.wowhead.com/classic/item=2466/skullsplitter-fetish
   Notes:
   - Quest item for "Troll Witchery" (4 required). Drops only from specific
     Skullsplitter caster mobs (Mystics and Witch Doctors), creating a
     knowledge-gated grind where incorrect mob selection inflates perceived
     grind time.
   - Upstream DB values (-80) are high-magnitude legacy rates and materially
     exceed observed telemetry.
   - Wowhead telemetry indicates ~9–11% baseline across eligible mobs,
     yielding a policy-derived normalization target of -15.
   - Magnitude-collapse pacing compensation applied (+10) to avoid punitive
     outcomes after normalization while preserving Classic grind texture.
   - Equalized to -25 across eligible mobs to keep completion typically
     achievable within a focused session when targeting correctly.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -25
WHERE item = 2466
  AND entry IN (780, 670);



/* ---------------------------------------------------------------------
   Item: 1524 - Skullsplitter Tusk
   Source: https://www.wowhead.com/classic/item=1524/skullsplitter-tusk
   Notes:
   - Buff from -21 to -30 to reduce punitive grind on a high-count (18) quest item.
   - Comment corpus supports hour-plus farming as common, but also indicates materially
     better outcomes when focusing higher-yield Skullsplitter types; -30 preserves the
     grind-quest character while reducing worst-case frustration.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 1524
  AND entry IN (1059, 784, 783, 782, 781, 780, 696, 672, 670, 669, 667);

/* INSERTs */
INSERT IGNORE INTO creature_loot_template
(entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
VALUES
(1061, 1524, -30, 0, 1, 1, 0, 'Skullsplitter Tusk'),
(1062, 1524, -30, 0, 1, 1, 0, 'Skullsplitter Tusk');



/* ---------------------------------------------------------------------
   Item: 4104 - Snapjaw Crocolisk Skin
   Source: https://www.wowhead.com/classic/item=4104/snapjaw-crocolisk-skin
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 4104
  AND entry = 1152;



/* ---------------------------------------------------------------------
   Item: 3910 - Snuff
   Source: https://www.wowhead.com/classic/item=3910/snuff
   Notes:
   - Quest item (15 required) for the Bloodsail pirate quest loop. Intended to
     complete incidentally while farming Bloodsail mobs, not as a rarity spike.
   - Wowhead telemetry shows a clear split: Warlocks and Swashbucklers converge
     near ~40–42%, while other Bloodsail mobs commonly sit lower but up to 31%
   - Result: Warlock and Swashbuckler at -50; all other eligible mobs at -40.
   --------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 3910
  AND entry IN (1564, 1563);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 3910
  AND entry IN (1562, 1561, 2549, 2545, 1653, 1565, 4505, 2548, 2551, 4506, 2547, 2550,2546);

/* ---------------------------------------------------------------------
   Item: 3916 - Split Bone Necklace
   Source: https://www.wowhead.com/classic/item=3916/split-bone-necklace
   Notes:
   - High-count quest item (25 required) completed in a single terminal
     quest loop with no natural revisit path.
   - Wowhead telemetry-derived rates across Skullsplitter mobs cluster
     between ~12–18%, yielding a policy-derived normalization target of -20.
   - Historical Classic-era comments consistently report ~25% effective
     drop behavior, with completion commonly occurring around ~100 kills
     and notable long-tail variance near completion.
   - Drop rate equalized to -25 as a routing- and pacing-based override:
     preserves grind intent while avoiding punitive front-loaded completion
     in late-stage Stranglethorn Vale quest flow.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -25
WHERE item = 3916
  AND entry IN (1059, 784, 783, 782, 781, 780, 696, 672, 670, 669, 667);



/* ---------------------------------------------------------------------
   Item: 4016 - Zanzil's Mixture
   Source: https://www.wowhead.com/classic/item=4016/zanzils-mixture
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 4016
  AND entry IN (1490, 2534, 1488, 1489, 1491, 2536, 2537);

/* INSERTs */
INSERT IGNORE INTO creature_loot_template
(entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
VALUES
(2530, 4016, -50, 0, 1, 1, 0, 'Zanzil''s Mixture'),
(2535, 4016, -50, 0, 1, 1, 0, 'Zanzil''s Mixture');
