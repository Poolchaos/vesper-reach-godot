class_name Facing

enum Dir { DOWN, UP, LEFT, RIGHT }

# Resolve a movement vector to a 4-direction facing.
# Zero vector keeps the current facing (no flicker on stop). Dominant axis
# wins; an exact diagonal tie resolves vertical. Godot Y is down-positive.
static func from_vector(move: Vector2, current: Dir) -> Dir:
	if move.length_squared() < 0.0001:
		return current
	if absf(move.x) > absf(move.y):
		return Dir.RIGHT if move.x > 0.0 else Dir.LEFT
	return Dir.DOWN if move.y > 0.0 else Dir.UP
