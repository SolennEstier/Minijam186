extends CharacterBody2D
@onready var arrow: Node2D = $Arrow

signal throw_ball

var angle_move_speed = 2

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var force = 500
@onready var impact_point: Sprite2D = $Impact_point

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		if arrow.rotation_degrees > -90 :
			arrow.rotation_degrees -= angle_move_speed
	if Input.is_action_pressed("right"):
		if arrow.rotation_degrees < 0 :
			arrow.rotation_degrees += angle_move_speed
	if Input.is_action_just_pressed("throw"):
		throw_ball.emit(arrow.rotation_degrees)
		
		
	#En attente de la correction de la func calculate impact position
	var impact = calculate_impact_position(self.position)
	impact_point.position.x = impact[0]
	impact_point.position.y = impact[1]



	
#FAUX FAUX FAUX à recalculer
func calculate_impact_position(position_juggler):
	var impact_x = 1/gravity*(-force+gravity*self.position[0]+sqrt(force*force-2*gravity*self.position[1]))
	print(-force+gravity*self.position[0])
	var impact_y = position_juggler[1]
	var impact = [impact_x,impact_y]
	return impact
