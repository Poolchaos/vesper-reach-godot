# M1 - Movement win (player top-down movement + facing)

**Status:** DRAFT, awaiting Phillip-Juan's confirmation (design-before-component gate). No scene/script scaffolded until confirmed.
**Milestone:** B1 / roadmap M1 ([v1-architecture-and-roadmap.md](v1-architecture-and-roadmap.md)). Branch: `feat/m1-movement`.

## Goal
The "it moves" win: a placeholder character you move top-down with keyboard or controller, facing one of 4 directions. Proves the input layer, movement, camera, and the facing logic before any real rig exists.

## In scope
- A `Player` scene driven by the existing input actions (`move_*`).
- Top-down movement with `move_and_slide` in `_physics_process`, frame-rate independent.
- **4-direction facing resolution** as a pure, unit-tested function.
- A **placeholder visual** (simple shapes) that clearly shows position + current facing.
- A `Camera2D` following the player.
- The test framework installed + the facing-resolution unit test green.

## Out of scope (later milestones)
The cutout rig and real animations (M2-M3), idle/walk clips, attack/combat (M4), NPC/dialogue (M5), the animation state machine (M6), 8-direction (post-v1). No art beyond placeholders.

## Player node design
```
Player (CharacterBody2D)
├─ Visual (Node2D)            # placeholder: a body shape + a facing marker
│  ├─ Body (ColorRect or Polygon2D)
│  └─ FacingMarker (Polygon2D/ColorRect, offset toward the facing dir)
├─ Camera2D
└─ (script: player.gd)
```
- `player.gd` reads input, moves the body, and updates the `FacingMarker` from the resolved facing.
- Statically typed; movement in `_physics_process(delta)`; nodes cached with `@onready`. Nothing is spawned/freed in M1, so no leak surface yet.

## Movement
- Read a direction vector from the input actions: `Input.get_vector("move_left", "move_right", "move_up", "move_down")` (handles KB+M, arrows, and the analog stick with deadzone in one call).
- `velocity = dir * SPEED` (named constant, e.g. `const SPEED := 220.0`), then `move_and_slide()`. `get_vector` is already normalized, so no diagonal speed boost.

## Facing resolution (the unit-tested pure logic)
A standalone, node-free helper (`scripts/facing.gd`, `class_name Facing`) so it can be tested without the scene:
- Input: a movement `Vector2` and the current facing.
- Output: facing enum `{ DOWN, UP, LEFT, RIGHT }`.
- Rule (deterministic):
  - Zero/near-zero vector -> keep current facing (no flicker when stopping).
  - Else dominant axis wins: if `abs(x) > abs(y)` -> `RIGHT` (x > 0) or `LEFT` (x < 0); otherwise -> `DOWN` (y > 0) or `UP` (y < 0). Note Godot's Y is **down-positive**.
  - Exact diagonal tie (`abs(x) == abs(y)`): vertical wins (falls into the `else`), so a tie reads as UP/DOWN. Documented so the test asserts it.

Unit tests (must pass): zero-vector keeps facing; the four cardinals; a diagonal tie resolves vertical; an off-axis vector (e.g. `(-0.9, 0.1)`) resolves to the dominant axis (LEFT). Tests live in `tests/`.

## Test framework
Recommend **GUT** (Godot Unit Test) for simplicity: a Godot addon, tests extend `GutTest`, runs in-editor and headless via CLI (useful for later CI). GdUnit4 is the alternative (more features, built-in CLI runner). Per dependency safety I will surface the exact addon + version + source and confirm Godot 4.6.3 compatibility before installing. One open item below.

## Success criteria
- Moves smoothly with WASD / arrows / left stick; diagonals are not faster than cardinals.
- The facing marker updates to the correct one of 4 directions and holds facing when stopped.
- Holds 60 FPS in the running game.
- Facing-resolution unit tests are green.
- Phillip-Juan drives it in the running game and confirms it feels right (the §6 gate).

## Open item to confirm
- **Test framework:** GUT (recommended) or GdUnit4? (I will verify 4.6.3 compatibility + surface version before installing either.)
