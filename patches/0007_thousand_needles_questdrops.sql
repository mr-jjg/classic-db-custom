/*
Patch: 0007_thousand_needles_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 400 (Thousand Needles)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;400:1;0:0#0+1+19
*/



/* ---------------------------------------------------------------------
   Item: 5795 - Hardened Tortoise Shell
   Source: https://www.wowhead.com/classic/item=5795/hardened-tortoise-shell
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5795
  AND entry IN (4142, 4143, 4144);



/* ---------------------------------------------------------------------
   Item: 5809 - Highperch Venom Sac
   Source: https://www.wowhead.com/classic/item=5809/highperch-venom-sac
   Notes:
   - Normalized all droppers (including the rare elite) to a single value.
   - Policy-derived rate would be -20; applied +10 punish compensation due to collapse from -80.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 5809
  AND entry IN (4107, 4109, 4110, 5934);



/* ---------------------------------------------------------------------
   Item: 5853 - Intact Silithid Carapace
   Source: https://www.wowhead.com/classic/item=5853/intact-silithid-carapace
   Notes:
   - Equalized to max derived rate (15) across the silithid group per rounding + equalization rules.
   - Magnitude delta rule: existing -80 reduced to policy-derived -15.
   - Punish compensation applied for extreme collapse: -15 -> -25.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -25
WHERE item = 5853
  AND entry IN (4130, 4131, 4132, 4133);



/* ---------------------------------------------------------------------
   Item: 5794 - Salty Scorpid Venom
   Source: https://www.wowhead.com/classic/item=5794/salty-scorpid-venom
   Notes:
   - Equalized all droppers to the maximum policy-derived value to avoid mob targeting.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 5794
  AND entry IN (4139, 4140, 5937);



/* ---------------------------------------------------------------------
   Item: 5854 - Silithid Talon
   Source: https://www.wowhead.com/classic/item=5854/silithid-talon
   Notes:
   - Normalized all droppers (including the rare mob) to a single value.
   - Policy-derived maximum would be -30; applied +10 punish compensation due to collapse from -80.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -40
WHERE item = 5854
  AND entry IN (4130, 4131, 4132, 4133);



/* ---------------------------------------------------------------------
   Item: 5842 - Unrefined Ore Sample
   Source: https://www.wowhead.com/classic/item=5842/unrefined-ore-sample
   Notes:
   - Equalized all droppers (including the rare mob) to the maximum policy-derived value to avoid mob targeting.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -60
WHERE item = 5842
  AND entry IN (4113, 4116, 14427);
