/*
Patch: 0025_felwood_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 361 (Felwood)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;361:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 11503 - Blood Amber
   Source: https://www.wowhead.com/classic/item=11503/blood-amber
   Notes:
   - Comments strongly converge on a quest-conditional “near guaranteed” experience (many 15/15 reports across 1.12-era and Classic),
     with a small minority reporting slightly under 100% (e.g., 15/17), which is still consistent with “very high” in practice.
   - Implemented as a quest item at 100% (ChanceOrQuestChance = -100) to match the dominant experiential signal and eliminate any
     unnecessary variability for a simple 15-collect.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -100
WHERE entry IN (7100, 7101, 7104)
  AND item = 11503;



/* ---------------------------------------------------------------------
   Item: 13140 - Blood Red Key
   Source: https://www.wowhead.com/classic/item=13140/blood-red-key
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 7
WHERE item = 13140
  AND entry IN (7118, 7120, 7114, 14522, 14523, 9862);



/* --------------------------------------------------------------------------
   Item: 21377 - Deadwood Headdress Feather
   Source: https://www.wowhead.com/classic/item=21377/deadwood-headdress-feather
   Notes:
   - Telemetry shows a clear two-tier structure among Deadwood mobs rather than a single shared rate.
     Northern-camp mobs cluster near ~48–49%, while lower-camp southern mobs cluster around
     ~27–30%, with rare/quest mobs showing lower sample distortion.
   - Upstream already models this as a two-band system (35% vs 25%), but both tiers sit materially below
     the center mass of observed rates.
   - Applied policy-derived normalization by expanding the existing structure to match telemetry bands:
      - Upper tier → 50% (Shaman/Den Watcher/Avenger + Bloodmaw aligned with same camp tier)
      - Lower tier → 30% (Warrior/Gardener/Ror/Pathfinder/Ragepaw)
   - Preserves intentional targeting behavior (northern camp more efficient) while correcting systematic
     under-tuning relative to large-sample telemetry.
   -------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 50
WHERE item = 21377
  AND entry IN (7158, 7156, 7157, 9462);

UPDATE creature_loot_template
SET ChanceOrQuestChance = 30
WHERE item = 21377
  AND entry IN (7153, 7154, 9464, 7155, 14342);



/* --------------------------------------------------------------------------
   Item: 20741 - Deadwood Ritual Totem
   Source: https://www.wowhead.com/classic/item=20741/deadwood-ritual-totem
   -------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 5
WHERE item = 20741
  AND entry IN (7157, 7156, 7158);



/* --------------------------------------------------------------------------
   Item: 18622 - Flawless Fel Essence (Jaedenar)
   Source: https://www.wowhead.com/classic/item=18622/flawless-fel-essence-jaedenar
   Notes:
   - Magnitude delta collapse: -75 -> -8.
   - Policy-derived baseline from telemetry: ~3%, rounded and stabilized to 4% under the contract model.
   - Class quest item: public telemetry is structurally deflated by non-eligible kills; comment corpus
     consistently places this step as the slowest of the three essences, commonly reporting ~10–20 kills
     with occasional long tails.
   - Punish compensation applied (+4) to avoid making the most constrained step (low mob density, dungeon
     friction, limited targets) overly punitive in practice, resulting in final value of 8%.
   -------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -8
WHERE entry = 9862
  AND item  = 18622;
