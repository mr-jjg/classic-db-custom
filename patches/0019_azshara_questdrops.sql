/*
Patch: 0019_azshara_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 16 (Azshara)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;16:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 21137 - Blue Scepter Shard
   Source: https://www.wowhead.com/classic/item=21137/blue-scepter-shard
   Notes:
   - Scripted quest encounter (Maws) with near-deterministic telemetry (~96%).
   - Upstream -49 undervalues intended behavior; corrected to quest-conditional guaranteed drop.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 21137
  AND entry IN (15571);



/* ---------------------------------------------------------------------
   Item: 10839 - Crystallized Note
   Source: https://www.wowhead.com/classic/item=10839/crystallized-note
   Notes:
   - Flavor/joke note associated with looting Azsharite formations (world objects), not creature kills.
   - Upstream creature_loot_template entries are spurious cross-table pollution; removed per deletion rule.
   --------------------------------------------------------------------- */

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 10839
  AND entry IN (6147, 8761);



/* ---------------------------------------------------------------------
   Item: 20029 - Enchanted Coral
   Source: https://www.wowhead.com/classic/item=20029/enchanted-coral
   Notes:
   - Mage-only quest item; Wowhead telemetry is heavily diluted by non-quest kills.
   - Comment evidence consistently clusters around ~25–35% effective drop behavior.
   - Magnitude delta collapse applied from -80 to policy-derived ~-30 range.
   - +10 punish compensation applied to avoid excessive pacing regression after major normalization.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 20029
  AND entry IN (6195);



/* ---------------------------------------------------------------------
   Item: 20023 - Encoded Fragment
   Notes:
   - Rogue-only quest item; kill telemetry plausibly deflated by non-quest kills.
   - Pickpocket telemetry ~67% suggests high effective acquisition rate.
   - Magnitude delta collapse: -80 -> -50. No punish compensation.
   - Remove non-core droppers; equalize Forest Ooze and The Evalcharr.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE entry = 8766
  AND item  = 20023;

/* INSERTs */
INSERT INTO creature_loot_template (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
SELECT 8660, 20023, -50, 0, 1, 1, 0, 'Encoded Fragment'
WHERE NOT EXISTS (
  SELECT 1
  FROM creature_loot_template
  WHERE entry = 8660
    AND item  = 20023
);

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 20023
  AND entry IN (6377, 6378, 6379, 6380, 8762);



/* --------------------------------------------------------------------------
   Item: 18624 - Flawless Fel Essence (Azshara)
   Quest: Flawless Fel Essence (Warlock class quest)
   Zone: 16 (Azshara)
   Source: https://www.wowhead.com/classic/item=18624/flawless-fel-essence-azshara
   Notes:
   - Magnitude delta collapse: -75 -> -35. No punish compensation (class quest; comments anchored).
   - Wowhead kill telemetry is deflated by non-quest kills; comments carry more weight here.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -35
WHERE item = 18624
  AND entry IN (6200, 6201, 6202);



/* --------------------------------------------------------------------------
   Item: 20028 - Glittering Dust
   Quest: Magic Dust (Mage class quest)
   Zone: 16 (Azshara)
   Source: https://www.wowhead.com/classic/item=20028/glittering-dust
   Notes:
   - Policy-derived adjustment from comment cluster (~30–35% typical).
   - Wowhead telemetry is lower than comments; treated as deflated for quest-conditional drops.
   - Magnitude delta collapse: -80 -> -35. No punish compensation.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -35
WHERE item = 20028
  AND entry IN (6198, 6199);



/* --------------------------------------------------------------------------
   Item: 18704 - Mature Blue Dragon Sinew
   Quest: Mature Blue Dragon Sinew (Hunter class quest)
   Zone: 16 (Azshara)
   Source: https://www.wowhead.com/classic/item=18704/mature-blue-dragon-sinew
   Notes:
   - Telemetry for cobalt dragonkin clusters tightly around ~0.5%.
   - Upstream already uses 0.5% for primary cobalt droppers; General Colbatann
     (rare spawn in the same cluster) was slightly lower at 0.3%.
   - Equalized rare cobalt to the standard cobalt band for consistency.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 0.5
WHERE entry = 10196
  AND item  = 18704;



/* --------------------------------------------------------------------------
   Item: 20017 - Perfect Courser Antler
   Quest: Of Coursers We Know
   Zone: 16 (Azshara)
   Source: https://www.wowhead.com/classic/item=20017/perfect-courser-antler
   Notes:
   - Wowhead telemetry ~4.2% across all kills; treated as a lower bound due to
     inclusion of non-quest kills diluting quest-conditional drop rates.
   - Player comments consistently describe the objective as grindy/high variance,
     suggesting upstream -8% is somewhat generous for a 2-drop requirement.
   - Policy-derived adjustment selecting the higher-of-two anchor (~5%) as a
     conservative midpoint above telemetry while preserving intended pacing.
   - Expected pacing shift: ~25 kills (8%) -> ~40 kills (5%) for 2 drops.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -5
WHERE entry = 8761
  AND item = 20017;
