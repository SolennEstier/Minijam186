extends CharacterBody2D
@onready var juggler_sprite: AnimatedSprite2D = $juggler_sprite
const BALL_IN = preload("res://scenes/ball_in.tscn")
signal ball_caught
signal request_bouncing_info
@onready var all_ball: Path2D = $all_ball

var move_speed = 30
var level: int
var ball_is_bouncing = 0
var target_position = 0


func set_level(new_level):
	level = new_level
	if level == 3:
		juggler_sprite.animation = "skater_animation"

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("I collided with ", collision.get_collider().name)
	
	
func stop():
	velocity = Vector2(0,0)	

func new_ball():
	var new_ball=BALL_IN.instantiate()
	all_ball.add_child(new_ball)
	print('add a ball')
	
func _on_juggler_detection_area_body_entered(body: Node2D) -> void:
	request_bouncing_info.emit(body)
	print("requesting")


func move_towards_ball(ball_final_position):
	target_position = ball_final_position + 200
	print('le jongleur est en ', position.x, 'et larrivée en ', target_position )
	var x_speed = target_position  - (position.x)
	print(x_speed)
	if level == 0:
		move_speed = 0
	if level == 2 :
		move_speed = 120
	if level == 3:
		# TODO : implémenter ici le déplacement en skate joliment
		position.x = target_position
		move_speed = 0
	velocity = Vector2(x_speed, 0).normalized()*move_speed
	print(velocity)


func _on_main_send_bouncing_info(bouncing_info, body) -> void:
	var ball_is_bouncing = bouncing_info
	if ball_is_bouncing == 0:
		ball_caught.emit(body)
		velocity = Vector2(0,0)
		new_ball()
