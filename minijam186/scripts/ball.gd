extends RigidBody2D
@onready var ball_sprite: AnimatedSprite2D = $Ball_sprite


func _ready() -> void:
	gravity_scale = 0

func throw(angle: float, force, velocity):
	gravity_scale = 1
	ball_sprite.play()
	set_linear_velocity(velocity*1.04)
