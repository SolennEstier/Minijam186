extends RigidBody2D


var force = 600.0



func _ready() -> void:
	gravity_scale = 0

func throw(angle: float):
	gravity_scale = 1
	
	var coeff_speed_ver = tan(angle/180*3.14)
	var velocity = Vector2(1, coeff_speed_ver).normalized()*force
	apply_impulse(velocity)
