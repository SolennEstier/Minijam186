extends RigidBody2D

var throwing_speed_hor = 500

func _ready() -> void:
	gravity_scale = 0

	

func throw(angle: float):
	gravity_scale = 1
	var throwing_speed_ver = -tan(-angle/180*3.14)*throwing_speed_hor
	var velocity = Vector2(throwing_speed_hor, throwing_speed_ver)
	apply_impulse(velocity)
