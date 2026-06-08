# Vesper Reach (game)

Godot 4 project for the v1 Human chibi top-down sparring slice. Engine pinned to **Godot 4.6.3** (ADR-0001). Design and decisions live one level up in [../docs](../docs) and [../decisions](../decisions).

## Run
- Open in editor: `godot -e --path .`
- Play the main scene: `godot --path .`

## Layout
- `scenes/` - `.tscn` scenes (`test_scene.tscn` is the main scene)
- `scripts/` - GDScript
- `assets/` - art and rigs
- `tests/` - unit tests (test framework added at milestone M1, when the first testable logic lands)

## Input actions (keyboard + controller)
`move_up` `move_down` `move_left` `move_right` (WASD / arrows / left stick), `interact` (E / A button), `attack` (left mouse / Space / X button).
