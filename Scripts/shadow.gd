extends Area2D

signal entered_shadow
signal exited_shadow

func _on_body_entered(body: Node2D) -> void:
	if body.name=="Player":
		emit_signal("entered_shadow")



func _on_body_exited(body: Node2D) -> void:
	if body.name=="Player":
		emit_signal("exited_shadow")
