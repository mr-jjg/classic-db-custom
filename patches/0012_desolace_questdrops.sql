/*
Patch: 0012_desolace_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 405 (Desolace)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;405:1;0:0#0+1+19
*/



/* --------------------------------------------------------------------------
   Item: 6067 - Centaur Ear
   Source: https://www.wowhead.com/classic/item=6067/centaur-ear
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 6067
  AND entry IN (
    6068, 4642, 4641, 4640, 4645, 4639, 4635, 4638, 4632, 4634,
    4633, 4644, 4636, 4637, 4643, 4647, 4646, 4648, 4649, 4651,
    4653, 4652, 12977, 11559, 12976, 4655, 4654, 4657, 4656,
    5601, 5600, 4659, 4658, 5602, 6069, 5402, 6070
  );



/* --------------------------------------------------------------------------
   Item: 6079 - Crude Charm
   Source: https://www.wowhead.com/classic/item=6079/crude-charm
   Notes:
   - Selective uplift: Kolkar Centaur (4632) increased to -30.
   - Sampling bias acknowledged: Kolkar Waylayer (12976) and Kolkar Ambusher (12977)
     appear frequently in escort contexts and low-sample telemetry, where players
     are less likely to be on the charm quest; their rates are intentionally left
     unchanged.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 6079
  AND entry IN (4632);



/* --------------------------------------------------------------------------
   Item: 6252 - Doomwarder Blood
   Source: https://www.wowhead.com/classic/item=6252/doomwarder-blood
   Notes:
   - Quest-conditional gating: blood is sourced from Doomwarder Captain cohort and
     select named variants (Kaskk, Lord Azrethoc). Player reports consistently
     describe near-guaranteed drops once killing eligible mobs; non-eligible
     Doomwarders are a common false target.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 6252
  AND entry IN (4680, 14226, 5760);



/* --------------------------------------------------------------------------
   Item: 6250 - Felhound Brain
   Source: https://www.wowhead.com/classic/item=6250/felhound-brain
   Notes:
   - Quest-conditional behavior is consistently described as effectively 100%
     from the intended felhound-type mobs.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 6250
  AND entry IN (4685, 4678, 4681);



/* --------------------------------------------------------------------------
   Item: 20310 - Flayed Demon Skin
   Source: https://www.wowhead.com/classic/item=20310/flayed-demon-skin
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 6
WHERE item = 20310
  AND entry IN (4663, 4664, 4666, 4665, 4705, 4668, 4667, 13019);



/* --------------------------------------------------------------------------
   Item: 15849 - Ghost-o-plasm
   Source: https://www.wowhead.com/classic/item=15849/ghost-o-plasm
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 15849
  AND entry IN (11560);



/* --------------------------------------------------------------------------
   Item: Infernal Orb (7291)
   Source: Burning Blade Summoner (4668)
   Rationale:
   - Overwhelming historical evidence (Classic + pre-Classic)
     indicates a first-kill / on-quest guaranteed drop.
   - Numerous independent comments report 100% drop behavior
     when the quest is active, consistent with quest-gated loot.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 7291
  AND entry = 4668;



/* --------------------------------------------------------------------------
   Item: 6990 - Lesser Infernal Stone
   Source: https://www.wowhead.com/classic/item=6990/lesser-infernal-stone
   Notes:
   - Comments strongly indicate quest-gated behavior: near-100% when on-quest,
     with low observed aggregate rates due to many kills occurring off-quest.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 6990
  AND entry IN (4676, 11937);



/* --------------------------------------------------------------------------
   Item: 6251 - Nether Wing
   Source: https://www.wowhead.com/classic/item=6251/nether-wing
   Notes:
   - Quest-conditional behavior is consistently described as effectively 100%
     from the intended Nether demon cohort; observed lower telemetry is likely
     influenced by off-quest kills.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 6251
  AND entry IN (4682, 4679, 4684);



/* ---------------------------------------------------------------------------
   Item: 6442 - Oracle Crystal
   Source: https://www.wowhead.com/classic/item=6442/oracle-crystal
   Notes:
   - Upstream value (-100) is inconsistent with observed drop behavior and Wowhead empirical rate (~21%).
   - Contract application (conservative):
     - Magnitude delta correction baseline -> 30
     - Partial punish compensation / spawn friction adjustment -> 40
   --------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 6442
  AND entry IN (4718);



/* ---------------------------------------------------------------------------
   Item: 15878 - Rackmore's Silver Key
   Source: https://www.wowhead.com/classic/item=15878/rackmores-silver-key
   Notes:
   - Silver Key is the practical gate for the quest; reports frequently cite long tail grind on this key.
   - Drysnap Pincer is consistently identified as the most reliable farming target (player routing converges on it).
   - Targeted buff applied only to Drysnap Pincer to reduce punitive variance without globalizing the drop.
   --------------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -20
WHERE entry = 11563
  AND item = 15878;



/* ---------------------------------------------------------------------------
   Item: 17756 - Shadowshard Fragment
   Source: https://www.wowhead.com/classic/item=17756/shadowshard-fragment
   Notes:
   - Comment consensus indicates quest-on behavior is effectively guaranteed (commonly described as 100%).
   - Reports of low drop rates are attributable to being off-quest or incorrect mobs/locations.
   - Wowhead empirical rate is very high (~76%), consistent with near-deterministic quest drops.
   - Contract application:
     - Quest-gated, single-item requirement -> deterministic quest completion behavior.
   --------------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 17756
  AND entry IN (11777, 11778);
