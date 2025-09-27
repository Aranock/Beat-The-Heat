extends Node2D

@onready var player = $Player
@onready var camera = $Camera2D


func _ready() -> void:
	self.player.position = Vector2(576, 324)
	self.player.player_movement.connect(_on_player_emit_player_movement)

func _on_player_emit_player_movement() -> void:
	print("moved")
	var view = get_viewport_rect().size / 2
	var camera_pos = camera.global_position
	var bounds_uw = camera_pos.y - view.y #the camera bounds at the top
	var bounds_dw = camera_pos.y + view.y #the camera bounds at the bottom
	player.global_position.y = clamp(player.global_position.y, bounds_uw, bounds_dw)
