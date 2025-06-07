extends Node2D
@onready var player_body: CharacterBody2D = $player_body
@onready var ball: RigidBody2D = $Ball
@onready var juggler_body: CharacterBody2D = $juggler_body

var ball_scene = preload("res://scenes/ball.tscn")
var start_ball_position: Vector2
@onready var active_ball = ball

func _ready():
	start_ball_position = ball.position
	pass

func _on_juggler_body_ball_caught(body) -> void:
	print('attrapé !')
	body.queue_free()
	juggler_body.stop()
	# Lancer animation de bravo + son de bravo
	# Spawn a new ball
	var new_ball = ball_scene.instantiate()
	add_child(new_ball)
	new_ball.position = start_ball_position
	active_ball = new_ball
	pass # Replace with function body.

func ball_missed(body):
	body.queue_free()
	print("Raté !")
	## Remplacer ce qui suit par ce qui arrive quand le jongleur rate
	var new_ball = ball_scene.instantiate()
	add_child(new_ball)
	new_ball.position = start_ball_position
	active_ball = new_ball


func _on_player_body_throw_ball(angle) -> void:
	active_ball.throw(angle)


func _on_down_boundary_body_entered(body: Node2D) -> void:
	ball_missed(body)
	
