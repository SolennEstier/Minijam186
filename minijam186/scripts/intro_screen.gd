extends Control

@export var dialogue: Dialogue
var current_level: int
@onready var juggler_dialogue: RichTextLabel = $juggler_dialogue
@onready var player_dialogue: RichTextLabel = $player_dialogue


func _ready():
	LevelHandler.current_level += 1
	current_level = LevelHandler.current_level
	print(dialogue.transition[current_level])
	juggler_dialogue.text = dialogue.transition[current_level][0]
	player_dialogue.text = dialogue.transition[current_level][1]
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
