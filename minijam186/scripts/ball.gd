extends RigidBody2D
@onready var ball_sprite: AnimatedSprite2D = $Ball_sprite


signal has_bounced_enough



func _ready() -> void:
	gravity_scale = 0



func throw(angle: float, force, velocity):
	gravity_scale = 1
	ball_sprite.play()
	set_linear_velocity(velocity*1.04)


	

func _on_bouncing_timer_timeout() -> void:
	print("TIMEOUT")
	has_bounced_enough.emit(self)
