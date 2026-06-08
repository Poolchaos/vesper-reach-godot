extends Node2D

# Static world-space grid so the player's movement is visible while the
# camera follows. Drawn once (no per-frame cost); the camera scrolling over
# it is what reads as motion.

const CELL := 64
const EXTENT := 3000
const LINE := Color(0.42, 0.44, 0.48)

func _draw() -> void:
	for x in range(-EXTENT, EXTENT + 1, CELL):
		draw_line(Vector2(x, -EXTENT), Vector2(x, EXTENT), LINE, 1.0)
	for y in range(-EXTENT, EXTENT + 1, CELL):
		draw_line(Vector2(-EXTENT, y), Vector2(EXTENT, y), LINE, 1.0)
