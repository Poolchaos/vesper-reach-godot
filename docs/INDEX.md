# INDEX

## Current state
2026-06-08: Project bootstrapped; CLAUDE.md reconciled + trimmed lean. This is the 2D top-down chibi RPG that renders the inherited Vesper Reach world (3 races: Human/Aquarian/Florakin; 2 callings each + rare awakening). **Locked:** v1 = Candidate B Human-only sparring slice ([design/v1-slice.md](design/v1-slice.md)); 2D skeletal/cutout 4-dir (ADR-0002); engine = Godot 4 / free built-in bones, Spine deferred (ADR-0001). **All 5 planning phases are LOCKED - planning track complete.** v1 architecture + movement-first roadmap (M0-M7) + risk register in [design/v1-architecture-and-roadmap.md](design/v1-architecture-and-roadmap.md). Engine gate cleared; the build starts at M0 (install Godot 4.6.3, git init, project setup) on Phillip-Juan's go.

## Where to find things
- Operating rules: [CLAUDE.md](../CLAUDE.md)
- Full conventions / workflow / commit hygiene: [conventions.md](conventions.md)
- Decisions (ADRs): [../decisions/README.md](../decisions/README.md)
- Work log: [PROGRESS.md](PROGRESS.md)
- Active sprint queue: [SPRINT.md](SPRINT.md)
- Inherited world art (reference only): `Games/vesper-reach/src/assets/characters/races/`
- v1 scope (locked): [design/v1-slice.md](design/v1-slice.md)
- Parked out-of-phase ideas: [parking-lot.md](parking-lot.md)

## Next action
Planning is complete. On Phillip-Juan's go, start **Build M0 (Setup)**: install Godot 4.6.3 (pinned), `git init`, project skeleton, InputMap (KB+M + controller), empty TestScene, test framework. Then M1 (movement win). Roadmap: [design/v1-architecture-and-roadmap.md](design/v1-architecture-and-roadmap.md).
