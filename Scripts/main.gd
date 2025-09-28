extends Node2D

@onready var player = $Player
@onready var camera = $Camera2D
@onready var sun_area = $"Sun Area"
@onready var game_over_menu = $GameOverCanvas/GameOverMenu
@onready var distance_label = $DistanceLabel
@onready var heat_bar = $HeatBar
@onready var pause_menu = $PauseCanvas/PauseMenu
var heat_level = 50.0
var player_in_shadow : bool = false
var total_entered_shadows : int = 0
signal heat_updated
signal overheated
var previous_obstacle_position = -1
var distance = 0.0


@onready var obstacleTemplate = preload("res://Scenes/Obstacles.tscn")

var obstacles: Array = []

func _ready() -> void:
	randomize()
	self.player.position = Vector2(576, 324)
	self.heat_bar.get_node("LizardHeatIcon").position = Vector2(576, 25)
	self.player.player_movement.connect(_on_player_emit_player_movement)
	self.heat_updated.connect(self.player._on_main_heat_updated)
	self.overheated.connect(self.player._on_main_overheated)
	self.sun_area.game_over.connect(_on_sun_area_game_over)
	self.pause_menu.visible = false
	self.game_over_menu.visible = false

func _process(_delta: float) -> void:
	pause_game()

func _on_player_emit_player_movement() -> void:
	var view = get_viewport_rect().size / 2
	var camera_pos = camera.global_position
	var bounds_uw = camera_pos.y - view.y #the camera bounds at the top
	var bounds_dw = camera_pos.y + view.y #the camera bounds at the bottom
	player.global_position.y = clamp(player.global_position.y, bounds_uw, bounds_dw)

func game_over():
	game_over_menu.visible = true
	game_over_menu.pause()

func _on_sun_area_game_over():
	game_over()

func _on_obstacle_spawner_timeout() -> void:
	var generate_start_position = func():
		var get_random_position_excluding_range = func(previous_y, view_size):
			var up_or_down = randf_range(0,1)
			if up_or_down < (previous_y-150) / (view_size.y-200) or previous_y+200 > view_size.y-100:
				var new_pos = Vector2(view_size.x+30, randi_range(100, previous_y-200))
				return new_pos
			else:
				var new_pos = Vector2(view_size.x+30, randi_range(previous_y+200, view_size.y-100))
				return new_pos
				
		var view = get_viewport_rect().size
		var random_position = 0
		if previous_obstacle_position == -1:
			random_position = Vector2(view.x + 200, randi_range(100, view.y-100))
			previous_obstacle_position = random_position.y
		else:
			random_position = get_random_position_excluding_range.call(previous_obstacle_position, view)
			previous_obstacle_position = random_position.y
		return random_position
	var new_obstacle = obstacleTemplate.instantiate()
	new_obstacle.global_position = generate_start_position.call()
	add_child(new_obstacle)
	obstacles.append(new_obstacle)
	self.heat_updated.connect(new_obstacle._on_main_heat_updated)
	new_obstacle.get_node("Shadow").entered_shadow.connect(player_entered_shadow)
	new_obstacle.get_node("Shadow").exited_shadow.connect(player_exited_shadow)

func player_exited_shadow():
	total_entered_shadows-=1
	if total_entered_shadows <= 0:
		total_entered_shadows = 0
		player_in_shadow = false

func player_entered_shadow():
	total_entered_shadows+=1
	player_in_shadow = true

func pause_game():
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			get_tree().paused = true
			pause_menu.visible = true
			pause_menu.pause()
		elif get_tree().paused == true:
			pause_menu.resume()

func _on_heat_timer_timeout() -> void:
	var adjust_heat = func():
		if player_in_shadow:
			heat_level -= .139*1.5
			self.heat_bar.get_node("LizardHeatIcon").position = Vector2(((get_viewport_rect().size.x -200) * (heat_level/100))+100, 0)
		else:
			heat_level += 0.278*1.5
			self.heat_bar.get_node("LizardHeatIcon").position = Vector2(((get_viewport_rect().size.x -200) * (heat_level/100))+100, 0)
	adjust_heat.call()
	distance += 2*heat_level /100
	distance_label.text = "Distance: " + str(int(distance)) + "ft"
	if heat_level > 100:
		heat_level = 100.0
		game_over()
	elif heat_level<=0:
		heat_level = 0
		game_over()
	emit_signal("heat_updated", heat_level)
