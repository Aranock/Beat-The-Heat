extends RigidBody2D

var obstacle_max_speed = -800
var heat_level: float = 50.0

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	linear_velocity = Vector2(obstacle_max_speed*heat_level/100,0)

func _on_main_heat_updated(ht_lvl):
	heat_level = ht_lvl
