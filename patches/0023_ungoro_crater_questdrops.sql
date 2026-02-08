/*
Patch: 0023_ungoro_crater_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 490 (Un'Goro Crater)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;490:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 11316 - Bloodpetal
   Source: https://www.wowhead.com/classic/item=11316/bloodpetal
   Notes:
   - Magnitude delta collapse: upstream -80 across all droppers vs policy-derived band (~20–30% from telemetry).
   - Normalized to -40 with punish compensation applied to avoid over-collapsing a 15-count collect quest.
   - Equalized across all Bloodpetal types; telemetry differences are small and Trapper sample size is lowest.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 11316
  AND entry IN (6509, 6510, 6511, 6512);



/* ---------------------------------------------------------------------
   Item: 11315 - Bloodpetal Sprout
   Source: https://www.wowhead.com/classic/item=11315/bloodpetal-sprout
   Notes:
   - Player comments consistently describe acquisition as harvesting ground spawns across Un'Goro, not mob drops.
   - Wowhead telemetry showing elite targets with tiny percentages is consistent with false attribution and/or legacy loot wiring.
   - Remove from creature_loot_template entirely for these entries (ground spawn handled elsewhere).
   --------------------------------------------------------------------- */

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 11315
  AND entry IN (
    6498, 6499, 6500, 6501, 6502, 6503,
    6505, 6506, 6507, 6508, 6509, 6510,
    6511, 6512, 6513, 6514, 6516, 6517,
    6518, 6519, 6527, 6551, 6552, 6553,
    6556, 6557, 6559, 6560, 9162, 9163,
    9164, 9165, 9166, 9167
  );



/* ---------------------------------------------------------------------
   Item: 11114 - Dinosaur Bone
   Source: https://www.wowhead.com/classic/item=11114/dinosaur-bone
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 11114
  AND entry IN (9162, 9163, 6504, 9164, 6502, 6501, 6503);



/* ---------------------------------------------------------------------
   Item: 11108 - Faded Photograph
   Source: https://www.wowhead.com/classic/item=11108/faded-photograph
   Notes:
   - This item is obtained from the quest container flow (“A Small Pack”), not from creature kills; upstream creature
     droppers are spurious and are removed per the Deletion Rule (delete rows, do not zero them). 
   --------------------------------------------------------------------- */

/* DELETEs */
DELETE FROM creature_loot_template
WHERE item = 11108
   AND entry IN (2659, 2726, 6505, 6506, 6507, 6517, 6520, 6521, 6556, 6557, 9118, 9163, 9164, 9167, 10660);



/* ---------------------------------------------------------------------
   Item: 11837 - Gorishi Scent Gland
   Source: https://www.wowhead.com/classic/item=11837/gorishi-scent-gland
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 11837
  AND entry IN (6551, 6552, 6553, 6554, 6555, 10040);



/* ---------------------------------------------------------------------
   Item: 22435 - Gorishi Sting
   Source: https://www.wowhead.com/classic/item=22435/gorishi-sting
   Notes:
   - Class quest item; telemetry is structurally deflated. Comment corpus 
     consistently supports ~30–40% in-quest drop from eligible flying mobs.
   - Restricted droppers to flying Gorishi (Wasp/Stinger) per quest text; 
     removed ground silithids (Worker/Reaver/Tunneler/Hive Guard).
   - Hive Queen acts as a burst source; corrected quantity band to 2–4 
     while preserving guaranteed quest-conditional drop.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE entry IN (6551, 6554)
  AND item = 22435;

UPDATE creature_loot_template
SET maxcount = 4
WHERE entry = 10041
  AND item = 22435;

/* DELETEs */
DELETE FROM creature_loot_template
WHERE entry IN (6552, 6553, 6555, 10040)
  AND item = 22435;



/* ---------------------------------------------------------------------
   Item: 11834 - Super Sticky Tar
   Source: https://www.wowhead.com/classic/item=11834/super-sticky-tar
   Notes:
   - Telemetry shows stable stratification (~46% vs ~41%) between lower tar mobs and higher variants.
   - Comment corpus consistently reinforces that Tar Creepers/Beasts are preferred farming targets.
   - Equalization intentionally declined to preserve this persistent behavioral signal.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -55
WHERE entry IN (6517, 6527)
  AND item = 11834;

UPDATE creature_loot_template
SET ChanceOrQuestChance = -45
WHERE entry IN (6519, 6518)
  AND item = 11834;



/* ---------------------------------------------------------------------
   Item: 11478 - Un'Goro Gorilla Pelt
   Source: https://www.wowhead.com/classic/item=11478/ungoro-gorilla-pelt
   Notes:
   - Upstream quest-conditional value is -100 (guaranteed), which contradicts observed gameplay and modern telemetry,
     triggering a magnitude-delta collapse.
   - Wowhead telemetry (~19–21%) would policy-derive to a 30–40% band after rounding + limited pacing compensation,
     but the quest comment corpus contains no “grindy drop rate” complaints, which is unusual for a truly 30–40% quest.
   - Corroboration via multiple Classic-era gameplay samples (YouTube) consistently shows high early success density
     (e.g., 6/6, 6/7, 6/9), so we apply an evidence-backed pacing override up to the contract’s cap, landing at -60.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE entry = 6514
  AND item = 11478;



/* ---------------------------------------------------------------------
   Item: 11479 - Un'Goro Stomper Pelt
   Source: https://www.wowhead.com/classic/item=11479/ungoro-stomper-pelt
   Notes:
   - Upstream quest-conditional value is -100 (guaranteed), which contradicts observed gameplay and modern telemetry,
     triggering a magnitude-delta collapse.
   - Wowhead telemetry (~19–21%) would policy-derive to a 30–40% band after rounding + limited pacing compensation,
     but the quest comment corpus contains no “grindy drop rate” complaints, which is unusual for a truly 30–40% quest.
   - Corroboration via multiple Classic-era gameplay samples (YouTube) consistently shows high early success density
     (e.g., 6/6, 6/7, 6/9), so we apply an evidence-backed pacing override up to the contract’s cap, landing at -60.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE entry = 6514
  AND item = 11479;



/* ---------------------------------------------------------------------
   Item: 11480 - Un'Goro Thunderer Pelt
   Source: https://www.wowhead.com/classic/item=11480/ungoro-thunderer-pelt
   Notes:
   - Upstream quest-conditional value is -100 (guaranteed), which contradicts observed gameplay and modern telemetry,
     triggering a magnitude-delta collapse.
   - Wowhead telemetry (~19–21%) would policy-derive to a 30–40% band after rounding + limited pacing compensation,
     but the quest comment corpus contains no “grindy drop rate” complaints, which is unusual for a truly 30–40% quest.
   - Corroboration via multiple Classic-era gameplay samples (YouTube) consistently shows high early success density
     (e.g., 6/6, 6/7, 6/9), so we apply an evidence-backed pacing override up to the contract’s cap, landing at -60.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE entry = 6516
  AND item = 11480;



/* ---------------------------------------------------------------------
   Item: 11830 - Webbed Diemetradon Scale
   Source: https://www.wowhead.com/classic/item=11830/webbed-diemetradon-scale
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 11830
  AND entry IN (9162, 9163, 9164);



/* ---------------------------------------------------------------------
   Item: 11831 - Webbed Pterrordax Scale
   Source: https://www.wowhead.com/classic/item=11831/webbed-pterrordax-scale
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE entry = 9165
  AND item = 11831;

UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE entry IN (9166, 9167)
  AND item = 11831;
