# INDEX

## Current state
2026-06-08: Project bootstrapped; CLAUDE.md reconciled + trimmed lean. This is the 2D top-down chibi RPG that renders the inherited Vesper Reach world (3 races: Human/Aquarian/Florakin; 2 callings each + rare awakening). **Locked:** v1 = Candidate B Human-only sparring slice ([design/v1-slice.md](design/v1-slice.md)); 2D skeletal/cutout 4-dir (ADR-0002); engine = Godot 4 / free built-in bones, Spine deferred (ADR-0001). **Planning complete; building.** All 5 planning phases locked. **M0-M2 complete** (all verified by Phillip-Juan, on main): Godot 4.6.3 project + GUT tests (M0); top-down movement (M1); and the articulated down-facing character (M2) - a 2-bone knee/elbow CharacterRig (cut from AI-generated parts) with idle + a research-grounded walk, depth ordering, driven by movement. Aesthetic is now futuristic Solo-Leveling chibi. Next: **M4 (attack + sparring combat beat)**. Roadmap: [design/v1-architecture-and-roadmap.md](design/v1-architecture-and-roadmap.md).

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
**M4 (attack + combat beat):** author the attack animation (anticipation/strike/follow-through/recovery) with a hit event on the strike frame; add the sparring opponent (reuses CharacterRig, recoloured) with hp/hit_react/defeat. Optional parallel art task: up/side facings so the character turns to face the move direction.
