extends Node2D
@onready var jump: AnimationPlayer = $jump
@onready var public_sprite: AnimatedSprite2D = $"public sprite"

func jumping():
	print('in jumping')
	jump.play('jump')

func choque_and_decu():
	public_sprite.pause()
