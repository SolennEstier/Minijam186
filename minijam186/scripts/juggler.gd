extends Node2D

signal ball_caught

func _process(delta: float) -> void:
	pass
	
	


func _on_juggler_detection_area_body_entered(body: Node2D) -> void:
	ball_caught.emit(body)
