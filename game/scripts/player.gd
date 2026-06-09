extends CharacterBody2D

const SPEED := 220.0

@onready var _rig: CharacterRig = $Visual

func _physics_process(_delta: float) -> void:
	var move := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move * SPEED
	move_and_slide()
	_rig.play(&"walk" if move != Vector2.ZERO else &"idle")
