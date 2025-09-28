extends Control

func _ready() -> void:
	resume()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("menu_blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("menu_blur")

func _on_restart_button_down() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_exit_game_button_down() -> void:
	get_tree().quit()
