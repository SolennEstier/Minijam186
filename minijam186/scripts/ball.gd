extends RigidBody2D



func _ready() -> void:
	gravity_scale = 0

func throw(angle: float, force):
	gravity_scale = 1
	
	var coeff_speed_ver = tan(angle/180*3.14)
	var velocity = Vector2(1, coeff_speed_ver).normalized()*force
	apply_impulse(velocity)
