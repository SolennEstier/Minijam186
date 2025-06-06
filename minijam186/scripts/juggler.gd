extends Node2D

signal ball_caught

func _process(delta: float) -> void:
	pass
	
	


func _on_juggler_detection_area_body_entered(body: Node2D) -> void:
	ball_caught.emit(body)
	self.velocity = Vector2(0,0)

func move_towards_ball(ball_final_position):
	var x_speed = ball_final_position - self.position.x
	self.velocity = Vector2(x_speed, 0)
	pass
