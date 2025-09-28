extends Node2D

func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_controls_button_down() -> void:
	pass # Replace with function body.


func _on_controls_2_button_down() -> void:
	pass # Replace with function body.


func _on_exit_button_down() -> void:
	get_tree().quit()
