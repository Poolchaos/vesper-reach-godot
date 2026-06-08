extends GutTest

func test_zero_vector_keeps_current_facing() -> void:
	assert_eq(Facing.from_vector(Vector2.ZERO, Facing.Dir.LEFT), Facing.Dir.LEFT)
	assert_eq(Facing.from_vector(Vector2.ZERO, Facing.Dir.UP), Facing.Dir.UP)

func test_cardinals() -> void:
	assert_eq(Facing.from_vector(Vector2(1, 0), Facing.Dir.DOWN), Facing.Dir.RIGHT)
	assert_eq(Facing.from_vector(Vector2(-1, 0), Facing.Dir.DOWN), Facing.Dir.LEFT)
	assert_eq(Facing.from_vector(Vector2(0, 1), Facing.Dir.UP), Facing.Dir.DOWN)
	assert_eq(Facing.from_vector(Vector2(0, -1), Facing.Dir.DOWN), Facing.Dir.UP)

func test_diagonal_tie_resolves_vertical() -> void:
	assert_eq(Facing.from_vector(Vector2(1, 1), Facing.Dir.LEFT), Facing.Dir.DOWN)
	assert_eq(Facing.from_vector(Vector2(-1, -1), Facing.Dir.RIGHT), Facing.Dir.UP)

func test_off_axis_dominant_axis_wins() -> void:
	assert_eq(Facing.from_vector(Vector2(-0.9, 0.1), Facing.Dir.DOWN), Facing.Dir.LEFT)
	assert_eq(Facing.from_vector(Vector2(0.1, 0.9), Facing.Dir.LEFT), Facing.Dir.DOWN)
