extends CharacterBody2D

var player_speed : float = 200.0
signal player_movement

func _physics_process(delta):
	if Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
		velocity = Vector2(0,1) * player_speed
		move_and_slide()
		emit_signal("player_movement")
	elif Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		velocity = Vector2(0,-1) * player_speed
		move_and_slide()
		emit_signal("player_movement")
