# INDEX

## Current state
2026-06-08: Project bootstrapped; CLAUDE.md reconciled + trimmed lean. This is the 2D top-down chibi RPG that renders the inherited Vesper Reach world (3 races: Human/Aquarian/Florakin; 2 callings each + rare awakening). **Locked:** v1 = Candidate B Human-only sparring slice ([design/v1-slice.md](design/v1-slice.md)); 2D skeletal/cutout 4-dir (ADR-0002); engine = Godot 4 / free built-in bones, Spine deferred (ADR-0001). **Planning complete; building.** All 5 planning phases locked. **M0 (Setup)** and **M1 (movement win)** complete: Godot 4.6.3 project, GUT tests, and a movable placeholder player (WASD/arrows/stick + 4-dir facing) on a grid, verified by Phillip-Juan and merged to main. Next: **M2 (readability spike)** - rig the human + a convincing idle. Roadmap: [design/v1-architecture-and-roadmap.md](design/v1-architecture-and-roadmap.md).

## Where to find things
- Operating rules: [CLAUDE.md](../CLAUDE.md)
- Full conventions / workflow / commit hygiene: [conventions.md](conventions.md)
- Godot coding practices (performance / memory / leaks / signals): [godot-practices.md](godot-practices.md)
- Co-planning protocol (reuse for future planning): [co-planning-protocol.md](co-planning-protocol.md)
- Decisions (ADRs): [../decisions/README.md](../decisions/README.md)
- Work log: [PROGRESS.md](PROGRESS.md)
- Active sprint queue: [SPRINT.md](SPRINT.md)
- Inherited world art (reference only): `legacy/vesper-reach/src/assets/characters/races/`
- v1 scope (locked): [design/v1-slice.md](design/v1-slice.md)
- Parked out-of-phase ideas: [parking-lot.md](parking-lot.md)

## Next action
**M2 (readability spike):** write the human-cutout asset spec (docs/assets/human-cutout.md, per the asset-spec gate), decide how human.png gets cut into rig parts, then build the Skeleton2D rig and a convincing idle on the front/down facing. This tests the #1 risk (top-down cutout readability) cheaply.
