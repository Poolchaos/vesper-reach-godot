extends CharacterBody2D

const SPEED := 220.0
const MARKER_OFFSET := 28.0

@onready var _marker: Polygon2D = $FacingMarker

var _facing: Facing.Dir = Facing.Dir.DOWN

func _physics_process(_delta: float) -> void:
	var move := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move * SPEED
	move_and_slide()
	_facing = Facing.from_vector(move, _facing)
	_update_marker()

func _update_marker() -> void:
	match _facing:
		Facing.Dir.DOWN:
			_marker.position = Vector2(0, MARKER_OFFSET)
		Facing.Dir.UP:
			_marker.position = Vector2(0, -MARKER_OFFSET)
		Facing.Dir.LEFT:
			_marker.position = Vector2(-MARKER_OFFSET, 0)
		Facing.Dir.RIGHT:
			_marker.position = Vector2(MARKER_OFFSET, 0)
