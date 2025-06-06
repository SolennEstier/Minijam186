extends Node2D
@onready var player_body: CharacterBody2D = $player_body
@onready var ball: RigidBody2D = $Ball


func _on_juggler_body_ball_caught(body) -> void:
	print('attrapé !')
	body.queue_free()
	# Lancer animation de bravo + son de bravo
	pass # Replace with function body.

func ball_missed(body):
	body.queue_free()
	print("Raté !")


func _on_player_body_throw_ball(angle) -> void:
	ball.throw(angle)


func _on_down_boundary_body_entered(body: Node2D) -> void:
	ball_missed(body)
	
