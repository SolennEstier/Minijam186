extends RigidBody2D


func _ready() -> void:
	gravity_scale = 0

func throw(angle: float, force, velocity):
	gravity_scale = 1
	set_linear_velocity(velocity*1.04)
