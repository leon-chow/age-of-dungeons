extends VBoxContainer

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rich_text_label.text = "%s" % [GameManager.floor]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rich_text_label.text = "%s" % [GameManager.floor]
