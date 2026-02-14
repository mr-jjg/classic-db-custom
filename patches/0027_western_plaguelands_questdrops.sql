/*
Patch: 0027_western_plaguelands_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 28 (Western Plaguelands)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;28:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 20610 - Bloodshot Spider Eye
   Source: https://www.wowhead.com/classic/item=20610/bloodshot-spider-eye
   Notes:
   - Class quest item: Wowhead NPC telemetry is structurally deflated by non-eligible kills; comments consistently describe
     moderate completion pacing with multiple valid droppers (including carrion birds), so normalize to the existing -20
     baseline and remove the upstream -2 outliers via equalization.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -20
WHERE item = 20610
  AND entry IN (1821, 1824);



/* ---------------------------------------------------------------------
   Item: 13354 - Ectoplasmic Resonator
   Source: https://www.wowhead.com/classic/item=13354/ectoplasmic-resonator
   Notes:
   - Equalized to 40 for rep-loop friendliness (telemetry-anchored normalization plus pacing compensation).
   - Removed entries with no meaningful Classic evidence (non-existent/unverifiable NPCs).
   - Added Dreadwhisper (1849) as a meaningful rare dropper supported by telemetry.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 40
WHERE item = 13354
  AND entry IN (1804, 4472, 1802, 11873, 10411, 1852, 11078);

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 13354
  AND entry IN (4476, 1801, 1800);

/* INSERTs */
INSERT INTO creature_loot_template
(entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id, comments)
VALUES
(1849, 13354, 40, 0, 1, 1, 0, 'Ectoplasmic Resonator');



/* ---------------------------------------------------------------------
   Item: 13357 - Osseous Agitator
   Source: https://www.wowhead.com/classic/item=13357/osseous-agitator
   Notes:
   - Normalized to 15 based on telemetry (~5–10%) plus pacing compensation to keep the cauldron loop viable.
   - Equalized across the full skeletal drop ecosystem in Western Plaguelands to avoid mob targeting.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 15
WHERE item = 13357
  AND entry IN (1852, 1784, 1788, 1783, 1785, 1789, 1787, 10816, 11076, 11077);



/* ---------------------------------------------------------------------
   Item: 14619 - Skeletal Fragments
   Source: https://www.wowhead.com/classic/item=14619/skeletal-fragments
   Notes:
   - Andorhal skeletons are the intended source and are consistently reported as effectively guaranteed; normalized to -100.
   - Outside-Andorhal skeletons are treated as fallback droppers; upstream -80 is collapsed to a lower policy-derived band
     under the magnitude-delta exception while preserving quest viability on a 15-count step.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE item = 14619
  AND entry IN (1787, 1789, 1788);

UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 14619
  AND entry IN (1784, 1783, 1785);



/* ---------------------------------------------------------------------
   Item: 13356 - Somatic Intensifier
   Source: https://www.wowhead.com/classic/item=13356/somatic-intensifier
   Notes:
   - Normalized to 25 based on telemetry (~8–15%) plus pacing compensation to preserve rep-loop friendliness.
   - Equalized across the ghoul/zombie drop ecosystem in Western Plaguelands to avoid mob targeting.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 25
WHERE item = 13356
  AND entry IN (1850, 10580, 1793, 1796, 1852, 4475, 4474, 1794, 1795, 1805, 1791, 10801, 1847, 10836, 11075);



/* ---------------------------------------------------------------------
   Item: 20611 - Thick Black Claw
   Source: https://www.wowhead.com/classic/item=20611/thick-black-claw
   Notes:
   - Class quest item: telemetry is structurally deflated by non-eligible kills; anchor primarily to comment experience.
   - Upstream already uses -20 on key droppers; normalize Diseased Grizzly up from -2 to -20 to avoid “best mob” targeting
     and keep pacing consistent across the local drop set.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -20
WHERE entry = 1816
  AND item = 20611;
