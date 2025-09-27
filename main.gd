extends Node2D

@onready var player = $Player

func _ready() -> void:
	self.player.position = Vector2(576, 324)
