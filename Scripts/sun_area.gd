extends Area2D

signal game_over

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.queue_free()
		emit_signal("game_over")
