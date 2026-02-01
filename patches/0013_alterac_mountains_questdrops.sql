/*
Patch: 0013_alterac_mountains_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 36 (Alterac Mountains)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;36:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 3505 - Alterac Signet Ring
   Source: https://www.wowhead.com/classic/item=3505/alterac-signet-ring
   Notes:
   - Magnitude delta rule applies (existing -80 values collapsing to policy-derived ~30 band).
   - +10 punish compensation applied to avoid punitive pacing regression after normalization.
   - Equalized across all known droppers in this patch to prevent target-gaming.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 3505
  AND entry IN (2242, 2243, 2319, 2245, 2247, 14221, 2246);



/* ---------------------------------------------------------------------
   Item: 3715 - Bracers of Earth Binding
   Source: https://www.wowhead.com/classic/item=3715/bracers-of-earth-binding
   Notes:
   - Magnitude delta rule applies (existing -80 value collapsing into low-30 policy band).
   - +10 punish compensation applied to prevent punitive pacing regression.
   - +5 competition compensation applied due to sparse elemental density and surrounding humanoid pressure.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE entry = 2359
  AND item = 3715;



/* ---------------------------------------------------------------------
   Item: 3658 - Recovered Tome
   Source: https://www.wowhead.com/classic/item=3658/recovered-tome
   Notes:
   - Quest is Alliance-only; Wowhead telemetry is contaminated by
     quest-ineligible Horde kills, making observed rates a lower bound.
   - Horde players have multiple kill quests on these ogres, further
     depressing mixed-faction telemetry.
   - Repeated user reports consistently cite ~30–40% effective drop rates
     from non-elite ogres, with elites not required.
   - Upstream DB value (-15) underperforms both player experience and
     historical consensus for a short, paired questline.
   - Value equalized across all Crushridge ogres and conservatively raised
     to 25% to reflect corrected eligibility without overfitting anecdotes.
--------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 3658
  AND entry IN (2252, 2253, 2254, 2255, 2256, 2287, 2416);



/* ---------------------------------------------------------------------
   Item: 3714 - Worn Stone Token
   Source: https://www.wowhead.com/classic/item=3714/worn-stone-token
   Notes:
   - Applied magnitude delta normalization.
   - Telemetry + comments support frequent but non-guaranteed drops.
   - Coin-flip rate preserves difficulty driven by mob mechanics, not RNG.
--------------------------------------------------------------------- */

UPDATE creature_loot_template
SET ChanceOrQuestChance = -50
WHERE item = 3714
  AND entry IN (2271, 2272, 2358, 2415, 2628);
