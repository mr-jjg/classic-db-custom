/*
Patch: 0024_burning_steppes_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 46 (Burning Steppes)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;46:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 11467 - Blackrock Medallion
   Source: https://www.wowhead.com/classic/item=22138/blackrock-bracer
   Notes:
   - Wowhead quest telemetry slopes downward on higher level mobs (Warlock, Battlemaster), which is consistent with
     players outgrowing the quest and killing those entries off-quest; treat that stratification as sampling bias.
   - Player reports consistently describe stack drops (often 3-10 per drop) with high variance, not single-medallion drops.
   - Upstream clamps most entries to a fixed stack of 3 and also favors worgs at 45% vs 33% for orcs.
     Normalized all known droppers to a single profile: 40% chance with a 3-10 stack, preserving intended "lumpy" pacing
     while removing targeting incentives.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40,
    mincountOrRef       = 3,
    maxcount            = 10
WHERE item = 11467
  AND entry IN (7025, 7026, 7027, 7028, 7029, 7055, 9690, 9694, 9697, 10077);



/* --------------------------------------------------------------------------
   Item: 11266 - Fractured Elemental Shard
   Source: https://www.wowhead.com/classic/item=11266/fractured-elemental-shard
   Notes:
   - Telemetry shows strong stratification: War Reavers ~49% vs Greater Obsidian
     Elementals ~8%. Player comments consistently identify reavers as the preferred
     farming target and describe elementals as noticeably worse.
   - Upstream sets both at 50%, which erases this distinction. Reduced the elemental
     rate using policy-derived new_val (ceil(8) + 1 = 9) with punish compensation
     (+5) to maintain reasonable pacing for a 10-item collection quest.
   - Rare spawn (Malfunctioning Reaver) previously dropped 2–5 shards, but comment
     support for multi-drop behavior is weak and uncorroborated. Normalized to a
     standard single drop to match family behavior while preserving the 50% chance.
   - War Reavers left unchanged to preserve the authentic primary-target dynamic.
   -------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -14
WHERE entry = 7039
  AND item = 11266;

UPDATE creature_loot_template
SET mincountOrRef = 1,
    maxcount = 1
WHERE entry = 8981
  AND item = 11266;
