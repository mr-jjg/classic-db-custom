/*
Patch: 0022_blasted_lands_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 4 (Blasted Lands)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;4:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 8394 - Basilisk Brain
   Source: https://www.wowhead.com/classic/item=8394/basilisk-brain
   Notes:
   - Large-sample droppers cluster tightly at ~36–37%, supporting the upstream 40% baseline as directionally correct.
   - Deatheye is a rare spawn with smaller sample size; normalize it up to the common 40% to remove an unnecessary
     rare-spawn penalty while keeping the overall drop model consistent.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 40
WHERE entry = 8302
  AND item  = 8394;



/* ---------------------------------------------------------------------
   Item: 8392 - Blasted Boar Lung
   Source: https://www.wowhead.com/classic/item=8392/blasted-boar-lung
   Notes:
   - Large-sample droppers cluster tightly at ~37%, supporting the upstream 40% baseline as directionally correct.
   - Grunter is a rare spawn with smaller sample size; normalize it up to the common 40% to remove an unnecessary
     rare-spawn penalty while keeping the overall drop model consistent.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 40
WHERE entry = 8303
  AND item  = 8392;



/* --------------------------------------------------------------------------
   Item: 8244 - Flawless Draenethyst Sphere
   Source: https://www.wowhead.com/classic/item=8244/flawless-draenethyst-sphere
   Notes:
   - Zone-wide ambient drop is intentionally uniform at ultra-rare levels, with Teremus the Devourer
     acting as the deterministic boss source.
   - Upstream has a single outlier (Bonepicker) at 0.02% while all other ambient entries are 0.01%.
   - Normalized Bonepicker to 0.01% for consistency so that all non-boss sources are equalized.
   - This is a data hygiene adjustment.
-------------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 0.01
WHERE entry = 5983
  AND item = 8244;



/* ---------------------------------------------------------------------
   Item: 18623 - Flawless Fel Essence (Dark Portal)
   Source: https://www.wowhead.com/classic/item=18623/flawless-fel-essence-dark-portal
   Notes:
   - Class quest item (Warlock-only); public telemetry is structurally deflated because non-eligible kills
     contribute to the denominator.
   - Wowhead telemetry (~15%) and comment corpus both indicate a “few to several kills” experience band,
     commonly reporting ~3–10 attempts with occasional RNG tails.
   - Applying the class-quest weighting model (Case 3: telemetry ≈ comments), anchor toward the upper end
     of the experiential band to keep the step purposeful but not punitive.
   - Adjusted from upstream 75% to 20% to better match observed completion pacing while preserving intent.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -20
WHERE entry = 6011
  AND item  = 18623;



/* --------------------------------------------------------------------------
   Item: 10593 - Imperfect Draenethyst Fragment
   Source: https://www.wowhead.com/classic/item=10593/imperfect-draenethyst-fragment
   Notes:
   - Fragment is designed as a zone-wide ambient token drop from most Blasted Lands mobs,
     with upstream already modeling a flat ~3% baseline across nearly all entries.
   - One outlier exists: Bonepicker set to 0.8% while the rest of the population sits at 3%.
   - Telemetry and player reports do not support Bonepicker being a worse source; this appears
     to be a stray value rather than intentional differentiation.
   - Normalized to 3% to maintain consistency across the ambient drop pool.
   - Data hygiene adjustment only.
-------------------------------------------------------------------------- */

/* UPDATE */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 3
WHERE entry = 5983
  AND item = 10593;



/* ---------------------------------------------------------------------
   Item: 8393 - Scorpok Pincer
   Source: https://www.wowhead.com/classic/item=8393/scorpok-pincer
   Notes:
   - Large-sample dropper (Scorpok Stinger) clusters at ~36%, supporting the upstream 40% baseline as directionally correct.
   - Clack the Reaver is a rare spawn with smaller sample size; normalize it up to the common 40% to remove an unnecessary
     rare-spawn penalty while keeping the overall drop model consistent.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 40
WHERE entry = 8301
  AND item  = 8393;



/* ---------------------------------------------------------------------
   Item: 8391 - Snickerfang Jowl
   Source: https://www.wowhead.com/classic/item=8391/snickerfang-jowl
   Notes:
   - Large-sample droppers cluster tightly at ~35–38%, supporting the upstream 40% baseline as directionally correct.
   - Ravage is a rare spawn with smaller sample size; normalize it up to the common 40% to remove an unnecessary
     rare-spawn penalty while keeping the overall drop model consistent.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 40
WHERE entry = 8300
  AND item  = 8391;



/* ---------------------------------------------------------------------
   Item: 8396 - Vulture Gizzard
   Source: https://www.wowhead.com/classic/item=8396/vulture-gizzard
   Notes:
   - Large-sample dropper (Black Slayer) clusters at ~33%, supporting the upstream 40% baseline as directionally correct.
   - Spiteflayer is a rare spawn with smaller sample size; normalize it up to the common 40% to remove an unnecessary
     rare-spawn penalty while keeping the overall drop model consistent.
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 40
WHERE entry = 8299
  AND item  = 8396;
