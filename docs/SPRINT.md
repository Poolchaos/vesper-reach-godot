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

## [complete] B0 Build - Setup (Godot project)

Goal: install Godot 4.6.3 (pinned), `git init`, project skeleton, InputMap (KB+M + controller), empty TestScene.

- 2026-06-08: created
- 2026-06-08: complete - Godot 4.6.3 installed (~/Applications/Godot, symlinked `godot` on PATH); renamed 3d-game -> game; game/ scaffolded (test_scene main scene, gl_compatibility renderer, input map for KB+M + controller generated via tool script, verified clean load); git repo init + initial commit 5be4720; Games/ gitignored. Test framework deferred to B1.

## [complete] B1 Build - Movement win

Goal: top-down movement + input (KB+M/controller) with a placeholder visual, 4-dir facing resolution (unit-tested). The "it moves" win.

- 2026-06-08: todo
- 2026-06-08: in-progress - design doc confirmed; GUT 9.6.0 installed; Facing logic + Player + movement built; facing tests 4/4 green.
- 2026-06-08: complete - Phillip-Juan verified movement reads on screen (after the background-grid fix). SPEED=220 accepted. Commits 3ee13d3 + 4314aaf, merged to main.

## [complete] B2 Build - Rig + idle/walk (M2)

Goal: build the reusable CharacterRig from the v1 human's cut parts and get a convincing idle on the down facing. De-risks top-down cutout (the #1 project risk). Branch feat/m2-rig.

- 2026-06-08: todo
- 2026-06-09: in-progress - aesthetic shifted to futuristic Solo-Leveling chibi (CLAUDE.md); v1 human generated as an AI parts-sheet, sliced (tools/slice_sheet.py) into 6 named parts, assembled, CharacterRig.tscn built and wired into the Player (placeholder block removed). Loads clean, GUT 4/4. Idle + walk animation next.

Notes:
- Asset spec docs/assets/human-cutout.md; component design docs/design/character-component.md; prompts docs/image-prompts.md.
- 2 extra hands held in reserve (raw/slices part_05/part_08) - ignored for now per Phillip-Juan.
- 2026-06-09: complete - 2-bone knee/elbow rig; idle (breathing) + research-grounded walk (contact/passing stride, body bob, knee fold, arm swing); 3/4 depth z-order; both feet same direction (angled foot); alignment + arm/leg spacing tuned iteratively with Phillip-Juan and verified in-game. Tuning zoom dropped to 1.5x. Commits 3b5d397..ad2dc1e (+ 1c6a872 doc); merged to main.

Done/learned: rigging (Skeleton via Sprite2D-cutout FK), keyframing idle + walk, animation events deferred, the FK-poser tool (tools/slice_sheet.py + pose previews) to iterate animation off-engine while blind.

## [todo] B3 Build - Attack + combat beat (M4)

Goal: author the attack animation (anticipation/strike/follow-through/recovery) with a hit event on the strike frame (not a timer); add the sparring opponent (reuses CharacterRig, recoloured) with hp/hit_react/defeat; one attack input.

- 2026-06-09: todo (next; roadmap M4)

Notes:
- Animation discipline: hit detection fires on a named frame via an animation method/Call-Method track, never setTimeout/await.
- Opponent reuses the rig (recolour skin), so not art-blocked.
- Parallel art task (optional, when ready): up (back) + side facings so the character turns to face the move direction - same generate -> slice -> rig pipeline.
