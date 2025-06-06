extends CharacterBody2D
@onready var arrow: Node2D = $Arrow

signal throw_ball

var angle_move_speed = 2

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		if arrow.rotation_degrees > -90 :
			arrow.rotation_degrees -= angle_move_speed
	if Input.is_action_pressed("right"):
		if arrow.rotation_degrees < 0 :
			arrow.rotation_degrees += angle_move_speed
	if Input.is_action_just_pressed("throw"):
		throw_ball.emit()
