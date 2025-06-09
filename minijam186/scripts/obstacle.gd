extends StaticBody2D

var dragging = false
var of = Vector2(0,0)
@onready var collapse: CPUParticles2D = $collapse
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready():
	self.visible = false 
	
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - of
	

func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position
	collision_shape_2d.disabled = true

func _on_button_button_up() -> void:
	dragging = false
	collision_shape_2d.disabled = false
	
func start_collapse():
	collapse.emitting=true
