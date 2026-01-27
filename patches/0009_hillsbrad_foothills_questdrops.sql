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
   - Magnitude delta correction from -100 (100% quest-conditional) to policy-derived rate.
   - Base derivation from equalized low single-digit telemetry.
   - +5 punish compensation applied due to extreme upstream over-tuning.
   - Final value intentionally preserves “rare, gating item” identity without punitive grind.
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -13
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
   - Magnitude delta correction from -80 / -100 to policy-derived mid-rate.
   - Equalized across bear variants to avoid mob targeting.
   - Value reflects expected player level range and distributed spawn availability.
   --------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
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
   - Tier 0.5 quest component (Components of Importance).
   - Drops from elite undead on Purgation Isle, Hillsbrad Foothills.
   - Extremely low mob density and long respawn timers.
   - Telemetry indicates ~8% observed drop rate; upstream was incorrectly set to guaranteed (-100).
   - Normalized to 14% to preserve rarity while mitigating spawn contention.
   --------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -14
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
   - Quest-conditional drop (negative ChanceOrQuestChance).
   - Wowhead telemetry for Syndicate Shadow Mage shows ~28% (large sample).
   - Apply magnitude delta away from upstream -80 toward telemetry, plus a small
     accessibility bump due to limited camp / local competition.
   - Final value set to 40% (ChanceOrQuestChance = -40).
   --------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
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
