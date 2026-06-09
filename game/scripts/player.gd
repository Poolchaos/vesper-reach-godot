extends CharacterBody2D

const SPEED := 220.0

func _physics_process(_delta: float) -> void:
	var move := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move * SPEED
	move_and_slide()
