extends StaticBody2D

var dragging = false
var of = Vector2(0,0)

func _ready():
	self.visible = false 
	
func _process(delta: float) -> void:
	if dragging:
		self.visible = true
		position = get_global_mouse_position() - of
	

func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false
