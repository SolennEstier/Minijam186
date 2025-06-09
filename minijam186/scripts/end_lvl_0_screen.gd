extends Control

@export var dialogue: Dialogue
var current_level: int
@onready var player_dialogue: RichTextLabel = $player_dialogue
@onready var mechant_tete: AnimatedSprite2D = $mechant_tete
@onready var button: Button = $Button

var current_state = 0

func _ready():
	current_state = 0
	LevelHandler.current_level += 1
	mechant_tete.visible = true
	button.text = "But ..."
	
func _on_button_pressed() -> void:
	current_state +=1
	if current_state == 1:
		get_tree().change_scene_to_file("res://scenes/end_lvl1_screen.tscn")
	
		
		

	
	
