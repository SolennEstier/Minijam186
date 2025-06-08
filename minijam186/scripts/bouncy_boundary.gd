extends StaticBody2D
@onready var test_timer: TextEdit = $"test timer"
@onready var bouncing_timer: Timer = $bouncing_timer



#juste pour le debugging

func _process(delta: float) -> void:
	test_timer.set_text(str(bouncing_timer.get_time_left()))
