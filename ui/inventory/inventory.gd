extends Button

@onready var inventoryBtn: Button = $"."
@onready var player: CharacterBody2D = $"../../Player";

signal items_changed(indexes);

const cols = 4;
const rows = 5;
var slots = rows * cols;
var items = [];

signal toggle_inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventoryBtn.pressed.connect(self.inventory_button_pressed)
	for i in range(slots):
		items.append(Item.new());

func inventory_button_pressed():
	toggle_inventory.emit()

func add_item(index, item):
	var previous_item = items[index]
	items[index] = item
	emit_signal("items_changed", [index])
	return previous_item
	
func remove_item(index):
	print("removing");
	var previous_item = items[index].duplicate()
	items[index].clear()
	emit_signal("items_changed", [index])
	return previous_item
	
func set_item_quantity(index, amount):
	items[index].quantity += amount
	if items[index].quantity <= 0:
		remove_item(index)
	else:
		emit_signal("items_changed", [index])
