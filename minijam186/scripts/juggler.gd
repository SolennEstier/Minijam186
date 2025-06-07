extends CharacterBody2D
@onready var juggler_sprite: AnimatedSprite2D = $juggler_sprite

signal ball_caught

var move_speed = 30
var level: int

var target_position = 0

func _ready():
	pass

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

func _on_juggler_detection_area_body_entered(body: Node2D) -> void:
	ball_caught.emit(body)
	velocity = Vector2(0,0)

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
