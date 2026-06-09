class_name CharacterRig
extends Node2D

const BLEND := 0.15
# Travel speed (px/s) the base walk cycle is tuned for. Walk playback scales
# with actual speed against this, so step cadence tracks distance (no slide).
const WALK_REF := 130.0

@onready var _anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	play(&"idle")

func play(anim: StringName) -> void:
	if _anim.has_animation(anim) and _anim.current_animation != anim:
		_anim.play(anim, BLEND)

func set_speed(px_per_sec: float) -> void:
	if _anim.current_animation == &"walk":
		_anim.speed_scale = clampf(px_per_sec / WALK_REF, 0.0, 2.5)
	else:
		_anim.speed_scale = 1.0
