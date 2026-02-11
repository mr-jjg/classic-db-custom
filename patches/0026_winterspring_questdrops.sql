/*
Patch: 0026_winterspring_questdrops.sql
DB: v_mangos
Table: creature_loot_template
Zone: 618 (Winterspring)

Primary index:
https://www.wowhead.com/classic/items/quest?filter=16:72;618:1;0:0#0+1+19
*/



/* --------------------------------------------------------------------------
   Item: 12524 - Blue-feathered Amulet
   Source: https://www.wowhead.com/classic/item=12524/blue-feathered-amulet
   Notes:
   - Upstream values are -100 across all droppers, which implies immediate
     completion and effectively removes any RNG from the collection step.
   - Wowhead telemetry (~1–2%) is clearly deflated due to quest-conditional gating and
     off-quest kills polluting the denominator; it is not a reliable numeric anchor on its own.
   - Classic-era comments consistently describe fast but non-guaranteed acquisition:
      - Many first–third kill reports
      - A dense band of 4–10 kill experiences
      - A persistent right tail of 15–30+ kill anecdotes
     This distribution contradicts a -100 model while still indicating a high drop rate.
   - Policy-derived new_val from telemetry collapses to a low single-digit floor;
     apply pacing compensation cap of 30% to avoid punitive normalization from a -100 baseline.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -34
WHERE entry IN (7452, 7453, 7454)
  AND item = 12524;



/* ---------------------------------------------------------------------
   Winterspring E'ko Set (Cache-gated repeatables)
   Scope:
   - Items: all E'ko quest items associated with the Witch Doctor Mau'ari
     repeatable turn-ins (3x E'ko -> 3x Juju).

   Signal model and decision process:

   1) Establishing the telemetry floor (≈10%)
      - Weighted telemetry across all E’ko droppers:
        - Combined weighted rate: 10.08%
        - Combined excluding contaminated sets (Frostmaul + Wildkin): 9.97%
      - These independent aggregates converge tightly around ~10%, providing
        a stable empirical baseline for the observed acquisition environment.
      - Telemetry is treated as a floor because:
        - Many kills occur off-quest or without the Cache present.
        - Gating suppresses true drop visibility.
        - Repeatable-turn-in items are farmed inconsistently across sessions.
      - Conclusion: ~10% represents the best stable lower-bound estimate of the
        real acquisition rate under mixed sampling conditions.

   2) Why we do NOT set rates to 10%
      - A literal 10% implementation would replicate the telemetry floor rather
        than compensate for its known downward bias.
      - E’ko quests are repeatable 3-collect loops with no XP reward; pacing
        should feel reliable rather than grindy.
      - A modest uplift above the floor is warranted to:
        - Offset gating undercount
        - Stabilize variance across different mob families
        - Avoid streak-heavy outcomes on small farming samples

   3) Deriving the 15% baseline (anchored, not arbitrary)
      - Floor anchor: ~10%
      - Chosen uplift: +5 percentage points
      - Rationale:
        - Large enough to be meaningfully felt in 3-item loops
        - Small enough to preserve grind texture
        - Shifts expected kills per drop from ~10 → ~6–7
        - Aligns with the upper cluster of non-contaminated telemetry
          (e.g., Shardtooth/Winterfall families landing ~8–12%)

      - Result: 15% serves as a pacing correction derived from:
          (telemetry floor) + (systemic bias compensation)

   4) Handling contamination explicitly
      - Frostmaul telemetry (~40%) is inflated by elite group farming and
        multi-loot distribution effects; not treated as a true rate signal.
      - Wildkin telemetry (~3–4%) is likely suppressed by multi-purpose kills
        and off-objective farming dilution.
      - When both contaminated sets are removed, the combined weighted rate
        still converges to ~10%, reinforcing the floor model.

   5) Topology-based stratification (throughput correction)
      - After anchoring 15% as the pacing baseline, adjust only for
        travel/throughput differences:

        Tier A (camped / dense / high kill throughput): 15%
        - Frostmaul
        - Frostsaber
        - Ice Thistle
        - Wildkin
        - Winterfall

        Tier B (sparse roamers / travel friction): 18%
        - Chillwind
        - Shardtooth

      - The +3% roamer bump compensates for travel time and lower pull density,
        not a different interpretation of drop signal.

   6) Outcome intent
      - Anchor design to measured telemetry (~10% floor).
      - Apply a modest, defensible uplift to correct systemic undercount.
      - Normalize by farming topology, not by noisy per-entry outliers.
      - Preserve the repeatable, grind-oriented nature of the E’ko ecosystem
        while removing extreme variance.
   --------------------------------------------------------------------- */



/* ---------------------------------------------------------------------
   Item: 12434 - Chillwind E'ko
   Source: https://www.wowhead.com/classic/item=12434/chillwind-eko
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -18
WHERE item = 12434
  AND entry IN (7447, 7448, 7449);



/* ---------------------------------------------------------------------
   Item: 12436 - Frostmaul E'ko
   Source: https://www.wowhead.com/classic/item=12436/frostmaul-eko
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 12436
  AND entry IN (7429, 7428);



/* ---------------------------------------------------------------------
   Item: 12430 - Frostsaber E'ko
   Source: https://www.wowhead.com/classic/item=12430/frostsaber-eko
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 12430
  AND entry IN (7433, 7430, 7432, 7434, 7431);



/* ---------------------------------------------------------------------
   Item: 12435 - Ice Thistle E'ko
   Source: https://www.wowhead.com/classic/item=12435/ice-thistle-eko
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 12435
  AND entry IN (7460, 7459, 7458, 7457);



/* ---------------------------------------------------------------------
   Item: 12432 - Shardtooth E'ko
   Source: https://www.wowhead.com/classic/item=12432/shardtooth-eko
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -18
WHERE item = 12432
  AND entry IN (7446, 7445, 7443, 7444);



/* ---------------------------------------------------------------------
   Item: 12433 - Wildkin E'ko
   Source: https://www.wowhead.com/classic/item=12433/wildkin-eko
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 12433
  AND entry IN (7453, 7454, 7452, 7451, 7450);



/* ---------------------------------------------------------------------
   Item: 12431 - Winterfall E'ko
   Source: https://www.wowhead.com/classic/item=12431/winterfall-eko
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -15
WHERE item = 12431
  AND entry IN (7438, 7439, 7440, 7442, 7441, 10916, 10738);



/* ---------------------------------------------------------------------
   Item: 12623 - Chillwind Meat
   Source: https://www.wowhead.com/classic/item=12623/chillwind-meat
   Notes:
   - Equalized across all droppers at 30% to remove stratification.
   - Reduction justified under quest collapse rule: existing upstream values imply materially faster completion
     than the grind-oriented experience consistently described in Classic-era comments.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 12623
  AND entry IN (7449, 7448, 7447);



/* ---------------------------------------------------------------------
   Item: 12334 - Frostmaul Shard
   Source: https://www.wowhead.com/classic/item=12334/frostmaul-shard
   Notes:
   - Primary acquisition path is environmental crystal nodes in Frostwhisper Gorge;
     creature drops act as a secondary fallback.
   - Wowhead telemetry for standard giants clusters tightly (~8–9%), while the 
     rare spawn (Kashoch the Reaver) shows an inflated rate (~31%) on a very small sample.
   - No player commentary indicates the rare is a preferred or intended high-value farming target.
   - Upstream -100 on the rare is an outlier inconsistent with both telemetry and the quest’s node-driven pacing.
   - Normalized the rare spawn to match the standard giants at -20 to remove an 
     unjustified optimization target and maintain uniform fallback behavior.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -20
WHERE entry = 10198
  AND item = 12334;



/* --------------------------------------------------------------------------
   Item: 12367 - Pristine Yeti Horn
   Source: https://www.wowhead.com/classic/item=12367/pristine-yeti-horn
   Notes:
   - Wowhead telemetry is stable and high-sample: ~24–25% on both Ice Thistle
     Matriarch and Patriarch.
   - Large number of player comments reporting extreme grind are likely polluted
     by kills on non-target yetis and mixed farming behavior; multiple comments
     explicitly note that only Matriarchs/Patriarchs drop the item.
   - Applied contract-derived new_val from the 24–25% band → 30%, normalized
     across both valid droppers.
-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE entry IN (7460, 7459)
  AND item = 12367;



/* ---------------------------------------------------------------------
   Item: 12622 - Shardtooth Meat
   Source: https://www.wowhead.com/classic/item=12622/shardtooth-meat
   Notes:
   - Equalized across all droppers at 30% to remove targeting incentives.
   - Reduction justified under magnitude delta rule (upstream values up to -62) combined with policy-derived normalization.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 12622
  AND entry IN (7445, 7443, 7444, 7446);



/* ---------------------------------------------------------------------
   Item: 22227 - Starbreeze Village Relic
   Source: https://www.wowhead.com/classic/item=22227/starbreeze-village-relic
   Notes:
   - Class quest item: public telemetry is systematically deflated by class-ineligible kills.
   - Comment corpus consistently describes a low single-digit experience with frequent long streaks.
   - Upstream is 100% quest-conditional, which is not supported by either telemetry (0.3%) or reports.
   - Magnitude-delta collapse: reduce to a policy-derived value and err generous for class-step pacing.
   - Set to 7% quest-conditional (ChanceOrQuestChance = -7) for both Frostmaul Giant and Frostmaul Preserver.
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -7
WHERE item = 22227
  AND entry IN (7428, 7429);



/* --------------------------------------------------------------------------
   Item: 18604 - Tears of the Hederine
   Source: https://www.wowhead.com/classic/item=18604/tears-of-the-hederine
   Notes:
   - Class quest item; Wowhead telemetry heavily diluted by non-quest kills.
   - Player reports cluster around ~15–25 kills for 5 items, with a wide bad-luck tail.
   - Upstream -80% implies near-trivial pacing and is inconsistent with reported experience.
   - Magnitude delta collapse to a mid-band value that preserves the grindy tone without making the step punitive.
   - No punish compensation (class quest; comments anchored).

-------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 18604
  AND entry IN (7461, 7462, 7463);



/* ---------------------------------------------------------------------
   Item: 12366 - Thick Yeti Fur
   Source: https://www.wowhead.com/classic/item=12366/thick-yeti-fur
   --------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -70
WHERE entry = 7457
  AND item = 12366;

UPDATE creature_loot_template
SET ChanceOrQuestChance = -70
WHERE entry = 7458
  AND item = 12366;



/* ---------------------------------------------------------------------
   Item: 12444 - Uncracked Chillwind Horn
   Source: https://www.wowhead.com/classic/item=12444/uncracked-chillwind-horn
--------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = -30
WHERE item = 12444
  AND entry IN (7447, 7448, 7449);



/* --------------------------------------------------------------------------
   Item: 20742 - Winterfall Ritual Totem
   Source: https://www.wowhead.com/classic/item=20742/winterfall-ritual-totem
   Notes:
   - Player experience consistently describes this as a low-frequency random drop while grinding Winterfall furbolgs
     for Timbermaw reputation; long dry streaks are a common complaint.
   - Wowhead telemetry clusters around ~3–4% for most droppers, with upstream DB values in the ~2.2–4.0% band.
   - Under the contract’s policy-derived model, baseline probability is derived from the most representative
     telemetry sample (7376 / 197944 ≈ 3.7%), then rounded up and given a +1 pacing compensation, yielding new_val = 6%.
   - Values are equalized across all Winterfall droppers to remove minor internal variance and ensure consistent
     experiential pacing for a one-time quest starter.
   -------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 6
WHERE item = 20742
  AND entry IN (7440, 7442, 7441, 10916, 7438, 7439, 10738);



/* --------------------------------------------------------------------------
   Item: 21383 - Winterfall Spirit Beads
   Quest: Beads for Salfa
   Source: https://www.wowhead.com/classic/item=21383/winterfall-spirit-beads
   Notes:
   - Telemetry centers most Winterfall mobs in the high-30s to low-40s, with Pathfinder/Den Watcher
     forming the upper edge of the band (~41–42%) and the rest clustering just below (~36–40%).
   - Upstream values (25–30%) are materially under-tuned relative to large-sample telemetry.
   - Applied a two-band normalization to reflect the observed distribution shape:
      - Upper band -> 50% (Pathfinder, Den Watcher) to preserve their position at the top of the cluster.
      - Core band -> 40% (Ursa, Totemic, Shaman, Runner, High Chief) to align with the modal center.
   - This keeps mild stratification where supported while lifting the overall drop cadence to match
     player-reported “~1 per 2–3 kills” experience.
   -------------------------------------------------------------------------- */

/* UPDATEs */
UPDATE creature_loot_template
SET ChanceOrQuestChance = 50
WHERE item = 21383
  AND entry IN (7442, 7440);

UPDATE creature_loot_template
SET ChanceOrQuestChance = 40
WHERE item = 21383
  AND entry IN (7438, 7441, 7439, 10916, 10738);
