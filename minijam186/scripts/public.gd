extends Node2D
@onready var jump: AnimationPlayer = $jump
@onready var public_sprite: AnimatedSprite2D = $"public sprite"



func _ready():
	public_sprite.frame = 0
	
func jumping():
	print('in jumping')
	public_sprite.animation='jump'
	jump.play('jump')
	await get_tree().create_timer(2.0).timeout
	public_sprite.animation='default'
	public_sprite.play()

func choque_and_decu():
	public_sprite.animation='default'
	public_sprite.pause()
