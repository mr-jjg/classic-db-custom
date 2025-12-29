/*
Patch: 0004_silverpine_forest_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 130 (Silverpine Forest)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16;130;0
*/



/* ---------------------------------------------------------------------
   Item: 3317 - A Talking Head
   Source: https://www.wowhead.com/classic/item=3317/a-talking-head
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 5
WHERE item = 3317
  AND entry IN (1939, 1940, 1942, 1943, 1944);



/* ---------------------------------------------------------------------
   Item: 3354 - Dalaran Pendant
   Source: https://www.wowhead.com/classic/item=3354/dalaran-pendant
   Notes:
   - Reduced from -80 to -50 under the magnitude delta rule.
   - Baseline policy-derived value from Mage/Protector telemetry (37–39%) is -40.
   - Punish compensation (+10) applied to prevent punitive collapse from legacy -80.
   - Dalaran Conjurors are equalized to the same value despite lower telemetry, as they
     are overleveled relative to the quest and not meaningfully targeted by players.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 3354
  AND entry IN (1912, 1914, 1915);



/* ---------------------------------------------------------------------
   Item: 3157 - Darksoul Shackle
   Source: https://www.wowhead.com/classic/item=3157/darksoul-shackle
   Notes:
   - Baseline policy-derived value from Wowhead telemetry (~47%) is -50.
   - Reduced from legacy -80 under the magnitude delta rule.
   - Punish compensation (+10) applied to prevent punitive collapse, resulting in -60.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 3157
  AND entry = 1782;



/* ---------------------------------------------------------------------
   Item: 3156 - Glutton Shackle
   Source: https://www.wowhead.com/classic/item=3156/glutton-shackle
   Notes:
   - Baseline policy-derived value from Wowhead telemetry (~51%) is -60.
   - Reduced from legacy -80 as a standard normalization.
   - Magnitude reduction is moderate; no punish compensation applied.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 3156
  AND entry = 1779;



/* ---------------------------------------------------------------------
   Item: 3253 - Grizzled Bear Heart
   Source: https://www.wowhead.com/classic/item=3253/grizzled-bear-heart
   Notes:
   - Baseline policy-derived value from Ferocious/Giant Grizzled Bear telemetry (25–28%) is -30.
   - Reduced from legacy -80 under the magnitude delta rule.
   - Punish compensation (+10) applied to prevent punitive collapse, resulting in -40.
   - No competition compensation applied: bears are abundant, easily targetable, and
     quest routing does not materially dilute effective kill rate.
   - Old Vicejaw is equalized to the same value for consistency despite lower rare telemetry.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 3253
  AND entry IN (1778, 1797, 12432);



/* ---------------------------------------------------------------------
   Item: 3258 - Hardened Tumor
   Source: https://www.wowhead.com/classic/item=3258/hardened-tumor
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 3258
  AND entry IN (1767, 1768, 1908, 1909, 1957, 1958);



/* ---------------------------------------------------------------------
   Item: 3257 - Lake Creeper Moss
   Source: https://www.wowhead.com/classic/item=3257/lake-creeper-moss
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -70
WHERE item = 3257
  AND entry IN (1955, 1956);



/* ---------------------------------------------------------------------
   Item: 3256 - Lake Skulker Moss
   Source: https://www.wowhead.com/classic/item=3256/lake-skulker-moss
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -70
WHERE item = 3256
  AND entry IN (1953, 1954);



/* ---------------------------------------------------------------------
   Item: 3218 - Pyrewood Shackle
   Source: https://www.wowhead.com/classic/item=3218/pyrewood-shackle
   Notes:
   - Baseline policy-derived value from aggregated Pyrewood/Moonrage elite telemetry
     (~24–34%) normalizes to -40.
   - Reduced from legacy -80 under the magnitude delta rule.
   - Punish compensation (+10) applied to prevent punitive collapse, resulting in -50.
   - No competition compensation applied: all relevant mobs in the quest area share
     the drop and are equivalently viable targets.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 3218
  AND entry IN (1891, 1892, 1893, 1894, 1895, 1896, 3528, 3529, 3530, 3531, 3532, 3533);



/* ---------------------------------------------------------------------
   Item: 3236 - Rot Hide Ichor
   Source: https://www.wowhead.com/classic/item=3236/rot-hide-ichor
   Notes:
   - Rare spawn Rot Hide Bruiser included and normalized with primary Rot Hide mobs
     to avoid drop variance driven by low telemetry sample size.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 3236
  AND entry IN (1939, 1940, 1942, 1943, 1944);



/* ---------------------------------------------------------------------
   Item: 3254 - Skittering Blood
   Source: https://www.wowhead.com/classic/item=3254/skittering-blood
   Notes:
   - Baseline policy-derived value from Moss Stalker / Mist Creeper telemetry
     (~28–33%) normalizes to -40.
   - Reduced from legacy -80 under the magnitude delta rule.
   - Punish compensation (+10) applied to prevent punitive collapse, resulting in -50.
   - No competition compensation applied: spiders are abundant, tightly clustered,
     and share the quest drop uniformly.
   - Rare mob (Krethis Shadowspinner) equalized for consistency.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 3254
  AND entry IN (1780, 1781, 12433);
