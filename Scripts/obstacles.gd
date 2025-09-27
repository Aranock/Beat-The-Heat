extends RigidBody2D

var speed = -200

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	linear_velocity = Vector2(speed,0)
