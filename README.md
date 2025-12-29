# classic-db-custom

Curated SQL patch set for Classic-era quest drop normalization.

## Scope
- Quest item drop rates
- Classic (1.12.x) era behavior
- Idempotent, ordered patches
- Designed for CMaNGOS / Classic DB schemas

## Structure
- `patches/` — Ordered SQL patches (0001_*, 0002_*, ...)
- `scripts/` — Helper scripts for applying patches
- `work/` — Local scratch space (gitignored)

## Principles
- No blind Wowhead mirroring
- Policy-driven normalization
- Preserve Classic pacing where appropriate
- Explicit documentation per item

## Usage
```bash
./scripts/update_database.sh
