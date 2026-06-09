class_name CharacterRig
extends Node2D

@onready var _anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	play(&"idle")

func play(anim: StringName) -> void:
	if _anim.has_animation(anim) and _anim.current_animation != anim:
		_anim.play(anim)
