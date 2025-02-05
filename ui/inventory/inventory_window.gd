extends SlotContainer

@onready var bottom_right_ui: Control = $"../../BottomRightUI"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_item_slots(Inventory.cols, Inventory.rows);
	await (get_tree())
	position = (get_viewport_rect().size - size) / 2;
	hide();
