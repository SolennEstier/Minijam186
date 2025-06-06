extends RigidBody2D


var force = 500.0
var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var impact_point: Sprite2D = $Impact_point

func _ready() -> void:
	gravity_scale = 0

func throw(angle: float):
	gravity_scale = 1
	
	var coeff_speed_ver = -tan(-angle/180*3.14)
	var velocity = Vector2(1, coeff_speed_ver).normalized()*force
	apply_impulse(velocity)
	
	var ball_position = self.position
	var impact = calculate_impact_position(ball_position)
	#print(impact)
	impact_point.position.x = 200 #impact[0]
	impact_point.position.y = 200 #impact[1]
	print(impact_point.position)
	

func calculate_impact_position(position_juggler):
	var impact_x = 1/gravity*(-force+gravity*position_juggler[0]+sqrt(force*force-2*gravity*position_juggler[1]))
	var impact_y = position_juggler[1]
	var impact = [impact_x,impact_y]
	return impact
