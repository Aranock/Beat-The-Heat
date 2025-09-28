extends Control


func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("menu_blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("menu_blur")

func testEsc():
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			pause()
		elif get_tree().paused == true:
			resume()

func _on_restart_button_down() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_unpause_button_down() -> void:
	resume()

func _on_exit_game_button_down() -> void:
	get_tree().quit()

func _process(delta: float) -> void:
	testEsc()
