extends Node2D

@onready var player = $Player
var playerSpeed : float = 50.0

func _ready() -> void:
	self.player.position = Vector2(576, 324)

func _physics_process(delta):
	if Input.is_action_pressed("down"):
		print("down")
	if Input.is_action_pressed("up"):
		print("up")
