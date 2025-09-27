extends CharacterBody2D

var player_speed : float = 50.0
var player_is_moving : bool = false

func _physics_process(delta):
	if Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
		velocity = Vector2(0,1) * player_speed
		player_is_moving = true
	elif Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		velocity = Vector2(0,-1) * player_speed
		player_is_moving = true
	else:
		player_is_moving = false
	if player_is_moving:
		move_and_slide()
