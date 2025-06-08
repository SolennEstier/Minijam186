extends Control

@export var dialogue: Dialogue
var current_level: int
@onready var juggler_dialogue: RichTextLabel = $juggler_dialogue
@onready var player_dialogue: RichTextLabel = $player_dialogue
@onready var jongleuse_tete: AnimatedSprite2D = $Node2D/jongleuse_tete
@onready var mechant_tete: AnimatedSprite2D = $mechant_tete
@onready var button: Button = $Button

var current_state = 0

func _ready():
	current_state = 0
	LevelHandler.current_level += 1
	current_level = LevelHandler.current_level
	print(dialogue.transition[current_level])
	mechant_tete.visible = false
	player_dialogue.visible = false
	jongleuse_tete.play()
	juggler_dialogue.text = dialogue.transition[current_level][0]
	player_dialogue.text = dialogue.transition[current_level][1]
	button.text = "Continue"
	
func _on_button_pressed() -> void:
	current_state +=1
	if current_state == 1:
		player_dialogue.visible = true
		mechant_tete.visible = true
		jongleuse_tete.stop()
		jongleuse_tete.frame = 0
		mechant_tete.play()
		button.text = "Start the show"
	if current_state == 2:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
		
		

	
	
