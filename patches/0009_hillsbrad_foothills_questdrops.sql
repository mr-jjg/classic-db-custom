/*
Patch: 0009_hillsbrad_foothills_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 267 (Hillsbrad Foothills)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;267:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 3477 - Creeper Ichor
   Source: https://www.wowhead.com/classic/item=3477/creeper-ichor
   Quest: Elixir of Suffering
   Notes:
   - Original upstream value of -100 caused extreme grind behavior.
   - Normalized under magnitude delta rule with pacing compensation applied.
   - Historical player reports indicate ~2–3% effective drop experience.
   - Final value preserves rarity while avoiding punitive collapse.
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -23
WHERE item = 3477
  AND entry IN (2350, 14279, 2349, 2348);



/* ---------------------------------------------------------------------
   Item: 3509 - Daggerspine Scale
   Source: https://www.wowhead.com/classic/item=3509/daggerspine-scale
   Quest: Elixir of Agony
   Notes:
   - Original upstream value of -80 produced disproportionately poor pacing.
   - Normalized under magnitude delta rule with punish compensation applied.
   - Historical reports indicate low but tractable drop rates (~30–40%).
   - No competition compensation applied due to isolated farming cohort.
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 3509
  AND entry IN (2370, 2368, 2371, 2369, 14277);



/* ---------------------------------------------------------------------
   Item: 3476 - Gray Bear Tongue
   Source: https://www.wowhead.com/classic/item=3476/gray-bear-tongue
   Quest: Elixir of Suffering
   Notes:
   - Original upstream values were -80 for common bears and -100 for the rare.
   - Normalized under magnitude delta rule with pacing compensation applied.
   - Historical reports indicate tongues are uncommon but generally acquired
     well before Creeper Ichor; target keeps tongues annoying but not gating.
   - Minor competition compensation applied due to shared farming loop with
     adjacent quest mobs (bears/spiders/lions) in the same route.
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -45
WHERE item = 3476
  AND entry IN (2351, 2354, 2356, 14280);



/* ---------------------------------------------------------------------
   Item: 3692 - Hillsbrad Human Skull
   Source: https://www.wowhead.com/classic/item=3692/hillsbrad-human-skull
   Notes:
   - Removed invalid loot sources: Purgation Isle high-level undead elites.
   - These NPCs are not part of the intended low-level Hillsbrad quest loop.
   - Normalized pervasive upstream -75 values to a policy-consistent -50.
     Upstream -75 is not representative of observed player experience for this quest,
     and the resulting grind is excessively punitive given the 30-count requirement.
     Setting -50 preserves the intended grind while avoiding a massive punish.
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 3692
  AND entry IN (
      2267, 2264, 2265, 2268, 2387,
      2404, 2335, 2449, 2448, 2451,
      2360, 2266, 2503, 2270, 2450,
      2305, 2261, 2269, 2260, 2244,
      2403, 2427, 2428, 232
  );

/* DELETE */
DELETE FROM creature_loot_template
WHERE item = 3692
  AND entry IN (7075, 7072, 7071, 7069, 7068, 7074);



/* ---------------------------------------------------------------------
   Item: 3496 - Mountain Lion Blood
   Source: https://www.wowhead.com/classic/item=3496/mountain-lion-blood
   Notes:
   - Upstream value of -15 significantly underrepresented observed drop rates.
   - Normalized to -30 to align with consistent player reports of ~25–35%
     effective drop experience.
   - This is a normalization and rounding adjustment, not a pacing compensation.
   - Preserves intended annoyance without creating excessive grind.
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 3496
  AND entry IN (2384, 2385, 2406, 2407);



/* ---------------------------------------------------------------------
   Item: 22229 - Soul Ashes of the Banished
   Source: https://www.wowhead.com/classic/item=22229/soul-ashes-of-the-banished
   Notes:
   - .5 dungeon set quest item obtained from elite undead on Purgation Isle.
   - Original -100 value produced extreme outliers (50–60 kills) under modern
     Classic population pressure and limited spawn availability.
   - Normalized via magnitude delta with punish compensation applied.
   - New value targets ~5 expected kills while preserving elite-gated pacing.
   --------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -19
WHERE item = 22229
  AND entry IN (7068, 7069, 7071, 7072, 7075);



/* ---------------------------------------------------------------------
   Item: 3510 - Torn Fin Eye
   Source: https://www.wowhead.com/classic/item=3510/torn-fin-eye
   Notes:
   - Quest reagent for the Hillsbrad chain (Elixir of Agony component).
   - Upstream values were -80 across the Torn Fin cohort.
   - Policy adjustment: magnitude delta normalization, with a small punish-compensation bump
     after the -80 collapse (policy baseline -40, +10pp compensation ⇒ -30).
   --------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 3510
  AND entry IN (2374, 2375, 14276, 2377, 2376);



/* ---------------------------------------------------------------------
   Item: 5620 - Vial of Innocent Blood
   Source: https://www.wowhead.com/classic/item=5620/vial-of-innocent-blood
   Notes:
   - Normalized from extreme upstream value (-80).
   - Applied magnitude delta correction.
   - Applied punish compensation (+10) for large collapse.
   - Applied competition compensation (+10) due to limited mob availability.
   - Final effective quest drop rate: 50%.
   --------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 5620
  AND entry = 2244;



/* ---------------------------------------------------------------------
   Item: 3720 - Yeti Fur
   Source: https://www.wowhead.com/classic/item=3720/yeti-fur#dropped-by
   --------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 3720
  AND entry IN (2248, 2249, 2250, 2251, 2452, 4504);
