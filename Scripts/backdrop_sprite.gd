extends Sprite2D

var background_max_speed = 800
@onready var destination = Vector2(-get_viewport_rect().size.x,get_viewport_rect().size.y/2)
var heat_level: float = 50.0
signal make_new_background

func _process(delta):
	self.global_position += self.global_position.direction_to(destination) * background_max_speed * (heat_level /100) * delta
	if self.global_position.x <= -get_viewport_rect().size.x:
		emit_signal("make_new_background")
		get_parent().queue_free()

func _on_main_heat_updated(ht_lvl):
	heat_level = ht_lvl
