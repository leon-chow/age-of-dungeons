extends Button

@onready var inventoryBtn: Button = $"."
@onready var player: CharacterBody2D = $"../../Player";
@onready var inventory_menu: GridContainer = $UI/CenterContainer/InventoryMenu

signal items_changed(indexes);
signal toggle_inventory;
signal selected_changed;

const cols = 4;
const rows = 5;
var slots = rows * cols;
var items = [];
var selected = 0;
var inventory_visible = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventoryBtn.pressed.connect(self.inventory_button_pressed)
	for i in range(slots):
		items.append(Item.new());
		
func broadcast_signal(indexes):
	emit_signal("items_changed", indexes)
	for index in indexes:
		if index == selected:
			emit_signal("selected_changed")		

func inventory_button_pressed():
	Inventory.inventory_visible = !Inventory.inventory_visible;
	toggle_inventory.emit()

func add_item(index, item):
	var previous_item = items[index]
	items[index] = item
	broadcast_signal([index])
	return previous_item
	
func set_selected(new_selected):
	var last_selected = selected;
	selected = new_selected;
	broadcast_signal([selected, last_selected])
	
func get_selected():
	return items[selected];
	
func remove_item(index):
	print("removing");
	var previous_item = items[index].duplicate()
	items[index].clear()
	broadcast_signal([index])
	return previous_item
	
func set_item_quantity(index, amount):
	items[index].quantity += amount
	if items[index].quantity <= 0:
		remove_item(index)
	else:
		broadcast_signal([index])
