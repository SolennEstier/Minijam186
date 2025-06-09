extends Node2D
@onready var player_body: CharacterBody2D = $player_body
@onready var ball: RigidBody2D = $Ball
@onready var juggler_body: CharacterBody2D = $juggler_body
@onready var public_bubble_1_timer: Timer = $public_bubble_1_timer
@onready var ballreceived: AudioStreamPlayer = $ballreceived
@onready var ballmissed: AudioStreamPlayer = $ballmissed
@onready var node_2d: Node2D = $Node2D
@onready var tutorial_1: RichTextLabel = $Tutorial1
@onready var tutorial_2: RichTextLabel = $Tutorial2
@onready var bouncing_timer: Timer = $bouncy_boundary/bouncing_timer
@onready var public_bubble_2: TextureRect = $public_bubble_2
@onready var public_bubble_3: TextureRect = $public_bubble_3
@onready var public_bubble_1: TextureRect = $public_bubble_1
@onready var rightparticule: CPUParticles2D = $rightparticule
@onready var rightparticule_2: CPUParticles2D = $rightparticule2
@onready var obstacle: StaticBody2D = $Obstacle
@onready var public_bubble_4: TextureRect = $public_bubble_4
@onready var light: Node2D = $Light

@onready var bouncy_boundary: StaticBody2D = $bouncy_boundary

signal send_bouncing_info
signal juggler_caught_it
signal juggler_failed

var ball_scene = preload("res://scenes/ball.tscn")
var start_ball_position: Vector2
var current_level: int
var fixed_moves = 2
var ball_is_bouncing = 0
var control_over_ball = 1
var number_of_missed_balls = 0
var number_of_caught_balls: int

@export var dialogue: Dialogue

@onready var active_ball = ball

func _ready():
	current_level = LevelHandler.current_level
	set_level(current_level)
	start_ball_position = ball.position
	public_bubble_1.visible = false
	public_bubble_2.visible = false
	public_bubble_3.visible = false
	if current_level > 0 :
		tutorial_2.visible = true
	if current_level > 1 :
		tutorial_1.visible = false
		tutorial_2.visible = false
	elif current_level == 0 :
		player_body.move_allowed = false
	if current_level == 4 :
		obstacle.visible = true
	number_of_caught_balls = 0


func _on_juggler_body_ball_caught(body) -> void:
	number_of_caught_balls += 1
	if current_level == 4 and number_of_caught_balls == 2:
		public_bubble_4.visible = true
	print('attrapé !')
	juggler_caught_it.emit()
	body.queue_free()
	juggler_body.stop()
	# Lancer animation de bravo + son de bravo
	# Spawn a new ball
	var new_ball = ball_scene.instantiate()
	add_child(new_ball)
	control_over_ball = 1
	ball_is_bouncing == 0
	new_ball.position = start_ball_position
	active_ball = new_ball
	active_ball.body_entered.connect(self._on_ball_body_entered)
	active_ball.has_bounced_enough.connect(self._on_ball_has_bounced_enough)
	active_ball.z_index =7
	bouncing_timer.timeout.connect(active_ball._on_bouncing_timer_timeout)
	public_congratulations()
	if current_level == 0:
		fixed_moves -= 1
		if fixed_moves == 0:
			player_body.move_allowed = true
			tutorial_2.visible = true

func ball_missed(body):
	number_of_missed_balls +=1
	body.queue_free()
	print("Raté !")
	## Remplacer ce qui suit par ce qui arrive quand le jongleur rate	
	if number_of_missed_balls != 2:
		var new_ball = ball_scene.instantiate()
		add_child(new_ball)
		control_over_ball = 1
		ball_is_bouncing == 0
		new_ball.position = start_ball_position
		active_ball = new_ball
		active_ball.body_entered.connect(self._on_ball_body_entered)
		active_ball.has_bounced_enough.connect(self._on_ball_has_bounced_enough)
		active_ball.z_index =7
		bouncing_timer.timeout.connect(active_ball._on_bouncing_timer_timeout)
	else:
		juggler_body.can_move = 0
		await get_tree().create_timer(0.2).timeout
		print("le niveau actuel est ", current_level)
		if current_level != 4:
			get_tree().change_scene_to_file("res://scenes/Intro_screen.tscn")
		if current_level == 4:
			get_tree().change_scene_to_file("res://scenes/end_lvl0_screen.tscn")

func _on_player_body_throw_ball(angle, impact_point, force, velocity) -> void:
	if control_over_ball == 1:
		active_ball.throw(angle, force, velocity)
		juggler_body.move_towards_ball(impact_point)
		control_over_ball = 0


func _on_down_boundary_body_entered(body: Node2D) -> void:
	if body.is_in_group('ball'):
		ball_missed(body)
	
	
func public_congratulations():
	rightparticule.emitting=true
	rightparticule_2.emitting=true
	var chosen_bubble = [public_bubble_1, public_bubble_2, public_bubble_3].pick_random()
	chosen_bubble.visible = true
	ballreceived.play()
	node_2d.jumping()
	await get_tree().create_timer(2.5).timeout
	chosen_bubble.visible = false

func set_level(new_level):
	juggler_body.set_level(new_level)
	player_body.level = new_level
	number_of_missed_balls = 0
	juggler_body.can_move = 1
	if new_level != 0:
		player_body.move_allowed = true


func _on_ball_body_entered(body: Node) -> void:
	if body.name == "bouncy_boundary" and ball_is_bouncing == 0:
		juggler_failed.emit()
		ballmissed.play()
		bouncing_timer.start()
		ball_is_bouncing = 1
		node_2d.choque_and_decu()

	
func _on_ball_has_bounced_enough(body) -> void:
	bouncing_timer.stop()
	ball_missed(body)
	ball_is_bouncing = 0


func _on_juggler_body_request_bouncing_info(body) -> void:
	send_bouncing_info.emit(ball_is_bouncing,body)
