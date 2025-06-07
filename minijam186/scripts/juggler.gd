extends CharacterBody2D

signal ball_caught

var move_speed = 200

var target_position = 0

func _ready():
	move_towards_ball(900)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("I collided with ", collision.get_collider().name)
	
	
func stop():
	velocity = Vector2(0,0)	

func _on_juggler_detection_area_body_entered(body: Node2D) -> void:
	ball_caught.emit(body)
	velocity = Vector2(0,0)

func move_towards_ball(ball_final_position):
	target_position = ball_final_position
	var x_speed = target_position - position.x
	velocity = Vector2(x_speed, 0).normalized()*move_speed
	print(velocity)
