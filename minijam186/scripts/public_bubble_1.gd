extends TextureRect
@onready var publicbubble_1_text: RichTextLabel = $publicbubble1text

func change_text(new_text):
	publicbubble_1_text.text = new_text
