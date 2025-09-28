extends Node2D

@onready var player = $Player
@onready var camera = $Camera2D
@onready var sun_area = $"Sun Area"
@onready var game_over_menu = $CanvasLayer/GameOverMenu


@onready var obstacleTemplate = preload("res://Scenes/Obstacles.tscn")

var obstacles: Array = []

func _ready() -> void:
	self.player.position = Vector2(576, 324)
	self.player.player_movement.connect(_on_player_emit_player_movement)
	self.sun_area.game_over.connect(_on_sun_area_game_over)

func _on_player_emit_player_movement() -> void:
	var view = get_viewport_rect().size / 2
	var camera_pos = camera.global_position
	var bounds_uw = camera_pos.y - view.y #the camera bounds at the top
	var bounds_dw = camera_pos.y + view.y #the camera bounds at the bottom
	player.global_position.y = clamp(player.global_position.y, bounds_uw, bounds_dw)

func _on_sun_area_game_over():
	game_over_menu.pause()

func _on_obstacle_spawner_timeout() -> void:
	var new_obstacle = obstacleTemplate.instantiate()
	var view = get_viewport_rect().size
	new_obstacle.global_position = Vector2(view.x + 200, randi_range(0, view.y))
	add_child(new_obstacle)
	obstacles.append(new_obstacle)
