extends Node2D
@onready var jump: AnimationPlayer = $jump

func jumping():
	print('in jumping')
	jump.play('jump')
