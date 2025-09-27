extends CharacterBody2D

signal player_obstacle_collision

func _physics_process(delta: float) -> void:
	move_and_slide()
	if global_position.x <= 0:
		queue_free()
