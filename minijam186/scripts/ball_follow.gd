extends PathFollow2D

var speed= 800
func _physics_process(delta: float) -> void:
	progress += delta*speed
