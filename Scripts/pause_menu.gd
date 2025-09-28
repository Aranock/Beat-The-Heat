extends Control

func _ready() -> void:
	resume()

func resume():
	$PauseAnimation.play_backwards("menu_blur")
	get_tree().paused = false
	self.visible = false
	
func pause():
	$PauseAnimation.play("menu_blur")

func _on_restart_button_down() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_exit_game_button_down() -> void:
	get_tree().quit()

func _on_resume_button_down() -> void:
	resume()
