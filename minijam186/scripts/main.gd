extends Node2D
@onready var player_body: CharacterBody2D = $player_body
@onready var ball: RigidBody2D = $Ball
@onready var juggler_body: CharacterBody2D = $juggler_body
@onready var public_bubble_1_timer: Timer = $public_bubble_1_timer
@onready var ballreceived: AudioStreamPlayer = $ballreceived
@onready var ballmissed: AudioStreamPlayer = $ballmissed

var ball_scene = preload("res://scenes/ball.tscn")
var start_ball_position: Vector2
@export var dialogue: Dialogue

@onready var active_ball = ball
@onready var public_bubble_1: TextureRect = $public_bubble_1

func _ready():
	start_ball_position = ball.position
	public_bubble_1.visible = false
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
	public_congratulations()
	pass # Replace with function body.

func ball_missed(body):
	body.queue_free()
	print("Raté !")
	## Remplacer ce qui suit par ce qui arrive quand le jongleur rate
	var new_ball = ball_scene.instantiate()
	add_child(new_ball)
	new_ball.position = start_ball_position
	active_ball = new_ball
	ballmissed.play()


func _on_player_body_throw_ball(angle, impact_point, force) -> void:
	active_ball.throw(angle, force)
	juggler_body.move_towards_ball(impact_point)


func _on_down_boundary_body_entered(body: Node2D) -> void:
	if body.is_in_group('ball'):
		ball_missed(body)
	
	
func public_congratulations():
	var message = dialogue.applause.pick_random()
	public_bubble_1.visible = true
	public_bubble_1.change_text(message)
	public_bubble_1_timer.start()
	ballreceived.play()
	
func _on_public_bubble_1_timer_timeout() -> void:
	public_bubble_1.visible = false
