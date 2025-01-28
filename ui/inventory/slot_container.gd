extends GridContainer;

class_name SlotContainer;

@onready var player: CharacterBody2D = $"../../Player"
@export var ItemSlot: PackedScene;

var slots;

func display_item_slots(cols, rows):
	columns = cols;
	slots = cols * rows
	for index in range(slots):
		var item_slot = ItemSlot.instance();
		add_child(item_slot)
		item_slot.display_item(player.inventory[index]);
	player.inventory.connect("items_changed", self)
