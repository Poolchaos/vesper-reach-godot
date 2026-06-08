# SPRINT

Single active sprint queue. One H2 per item. Statuses: complete | in-progress | todo | research-or-planning-needed | blocked.

## [complete] M01 Phase 1 - Concept & v1 scope

Goal: lock the exact smallest playable slice that is both a real game and a real animation lesson (one chibi human, top-down movement, one NPC interaction, one attack, core animation set), with deferrals named.

- 2026-06-08: created
- 2026-06-08: in-progress (candidate-variants turn presented)
- 2026-06-08: complete - Candidate B (sparring partner) locked; recolours accepted as temporary scaffolding. Canonical scope: docs/design/v1-slice.md.

## [complete] M02 Phase 2 - Animation approach

Goal: lock spritesheet vs 2D skeletal/cutout + facing strategy (4/8-dir) for chibi top-down, accounting for the later race/calling roster. Recorded in an ADR.

- 2026-06-08: created
- 2026-06-08: in-progress (live research on current 2D animation tools, then candidate-variants turn)
- 2026-06-08: complete - LOCKED 2D skeletal/cutout, 4-dir for v1 with a path to 8. See decisions/ADR-0002-animation-approach.md.

## [complete] M03 Phase 3 - Engine & tooling

Goal: ADR-0001 - engine + version, web-wrapped (Electron/Tauri) vs dedicated 2D engine compared on equal footing, named skeletal-animation tool, native desktop export + controller + Steam path.

- 2026-06-08: created
- 2026-06-08: in-progress (live research on engines + Steam integration + skeletal pipelines)
- 2026-06-08: complete - LOCKED Godot 4 (4.6.3), free built-in 2D bones, Spine deferred. ADR-0001 signed off; engine gate cleared.

## [complete] M04 Phase 4 - Animation learning path

Goal: deliberate rig -> idle -> walk -> attack -> generalize progression with per-step learning goals and success checks, on Godot's built-in bones.

- 2026-06-08: created
- 2026-06-08: in-progress (learning-path recommendation presented)
- 2026-06-08: complete - LOCKED 6-step path, learn in-project. See docs/design/animation-learning-path.md.

## [complete] M05 Phase 5 - Architecture & roadmap

Goal: v1 slice architecture (Godot scenes/systems), milestone build order by dependency, top risks + first thing to tackle.

- 2026-06-08: created
- 2026-06-08: in-progress (architecture + roadmap + risks presented)
- 2026-06-08: complete - LOCKED. Movement-first roadmap (M0-M7), architecture + risk register in docs/design/v1-architecture-and-roadmap.md. Planning track complete.

## [blocked] B0 Build - Setup (Godot project)

Goal: install Godot 4.6.3 (pinned), `git init`, project skeleton, InputMap (KB+M + controller), empty TestScene, test framework. First build milestone.

- 2026-06-08: created
- 2026-06-08: blocked - planning complete; starts on Phillip-Juan's "start building" go. Full build roadmap (M0-M7) in docs/design/v1-architecture-and-roadmap.md.
