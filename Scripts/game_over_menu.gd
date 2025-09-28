extends Control

var score = 0

func _ready() -> void:
	resume()

func resume():
	get_tree().paused = false
	self.visible =false
	
func pause(distance):
	get_tree().paused = true
	$GameOverAnimation.play("menu_blur")
	score = distance
	$PanelContainer/VBoxContainer/DistanceLabel.text = "You went " + str(int(distance)) + "mm"

func _on_restart_button_down() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_exit_game_button_down() -> void:
	get_tree().quit()
