extends ColorRect

@onready var item_name: Label = $MarginContainer/ItemName
@onready var margin_container: MarginContainer = $MarginContainer
@onready var tooltip: ColorRect = $"."

func _ready():
	EventBus.tooltip_show.connect(show_tooltip);
	EventBus.tooltip_closed.connect(hide_tooltip);	
	
func _process(delta: float) -> void:
	position = get_global_mouse_position() + Vector2.ONE * 4;
	
func hide_tooltip():
	hide();
	
func show_tooltip(item, position):
	item_name.text = item.itemName;
	show()
