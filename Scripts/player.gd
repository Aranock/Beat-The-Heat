extends CharacterBody2D

@onready var stun_timer = $StunTimer
@onready var fire_animation = $FireAnimation

var player_speed : float = 200.0
signal player_movement
var player_speed_position = 3
var stunned : bool = false

func _physics_process(_delta):
	var set_x_velocity = func():
		var player_destination = ((player_speed_position / 4.0) * (get_viewport_rect().size.x -200))
		if position.x < player_destination-5:
			return 0.3
		elif position.x > player_destination+5:
			return -0.3
		return 0
	if stunned:
		velocity=Vector2(-1,0) * player_speed
		move_and_slide()
	else:
		var x_velocity = set_x_velocity.call()
	
		if Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
			velocity = Vector2(x_velocity,1) * player_speed
			move_and_slide()
			emit_signal("player_movement")
		elif Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
			velocity = Vector2(x_velocity,-1) * player_speed
			move_and_slide()
			emit_signal("player_movement")
		else:
			velocity=Vector2(x_velocity,0)*player_speed
			move_and_slide()

func _on_main_heat_updated(ht_lvl):
	if ht_lvl > 75:
		player_speed_position =4
	else:
		if ht_lvl > 50:
			player_speed_position =3
		elif ht_lvl > 25:
			player_speed_position =2
		elif ht_lvl > 0:
			player_speed_position = 1

func _on_main_overheated():
	fire_animation.visible = false
	stunned = true
	stun_timer.start()

func _on_stun_timer_timeout() -> void:
	stunned = false
