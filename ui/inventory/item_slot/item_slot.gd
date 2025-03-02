extends ColorRect;

@onready var item_icon: TextureRect = $ItemIcon
@onready var item_quantity: Label = $ItemQuantity
@onready var item_slot: ColorRect = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item_slot in get_tree().get_nodes_in_group("item_slot"):
		var index = item_slot.get_index()
		item_slot.connect("gui_input", _on_itemSlot_gui_input.bind(index))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display_item(item):
	if item:
		var atlasTexture = AtlasTexture.new();
		atlasTexture.atlas = item.itemTexture
		atlasTexture.region = item.textureRegion;
		item_icon.texture = atlasTexture;
		item_quantity.text = str(item.quantity) if item.itemName != "test" else '';
	else:
		item_icon.texture = null;
		item_quantity.text = "";
	if get_index() == Inventory.selected:
		color = "#7b7b7b"
	else:
		color = "#333333"

func _on_itemSlot_gui_input(event, index):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if Inventory.inventory_visible == true:
				if index != Inventory.selected:
					Inventory.set_selected(index);
