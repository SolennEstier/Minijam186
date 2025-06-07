extends CharacterBody2D
@onready var arrow: Node2D = $Arrow
@onready var player_sprite: AnimatedSprite2D = $player_sprite
@onready var trajectory: Line2D = $Trajectory

@onready var impact_point: Sprite2D = $ImpactPoint



signal throw_ball

var angle_move_speed = 2
var force = 600

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var world_boundary_y = 42



func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		if arrow.rotation_degrees > -70 :
			arrow.rotation_degrees -= angle_move_speed
	if Input.is_action_pressed("right"):
		if arrow.rotation_degrees < 0 :
			arrow.rotation_degrees += angle_move_speed
		
	#updating trajectory
	var parabola_coeffs = determine_parabola(arrow.rotation_degrees)
	var impact_points = calculate_impact_points(parabola_coeffs)
	create_interpolation_points(parabola_coeffs,100, impact_points)
	
	if Input.is_action_just_pressed("throw"):
		throw_ball.emit(arrow.rotation_degrees,impact_points[0], force)
		
	#draw trajectory
	queue_redraw()
	
		
func determine_parabola(angle):
	
	var ball_velocity = Vector2(1, tan(angle/180*3.14)).normalized()*force
	#define parameters of the parabola
	var p1 = arrow.position.x
	var p2 = arrow.position.y 
	
	var a = gravity/2*(1/(ball_velocity[0]*ball_velocity[0]))
	var b = ball_velocity[1]/ball_velocity[0]
	var c = p2
	var parabola_coeffs = [a,b,c]
	return parabola_coeffs
	
func calculate_impact_points(parabola_coeffs):
	var p1 = arrow.position.x
	var p2 = arrow.position.y 
	
	var impact_point_y = world_boundary_y
	
	var a = parabola_coeffs[0]
	var b = -2*a*p1+parabola_coeffs[1]
	var c = a*p1*p1 + parabola_coeffs[2]- impact_point_y

	var impact_point_x = (-b+sqrt(b*b-4*a*c))/(2*a)
	impact_point.position.x = impact_point_x
	impact_point.position.y = impact_point_y
	
	var impact_points = Vector2(impact_point_x,impact_point_y)
	return impact_points
	
	
func create_interpolation_points(parabola_coeffs, n, impact_points):
	var a = parabola_coeffs[0]
	var b = parabola_coeffs[1]
	var c = parabola_coeffs[2]
	
	var p1 = arrow.position.x
	var p2 = arrow.position.y
	

	trajectory.clear_points()
	
	for i in range(n):
		var x = p1 + i*(impact_points[0]-p1)/n
		var new_point = Vector2(x, a*(x-p1)*(x-p1) + b*(x-p1) + c)
		if new_point[1] < impact_points[1]:
			trajectory.add_point(new_point)
	return 
	


func _draw():
	trajectory.closed = false
	draw_polyline(trajectory.points, Color.RED, 2.0)
	var arrow_test = Vector2(arrow.position.x,arrow.position.y)
	
	
	#attention à scale la gravité
