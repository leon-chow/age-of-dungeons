extends Control

signal forward_toggle_inventory 
@onready var inventoryBtn: Button = $MarginContainer/HBoxContainer/Inventory
@onready var inventory_menu: GridContainer = $"../CenterContainer/InventoryMenu"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if inventoryBtn:
		inventoryBtn.toggle_inventory.connect(Callable(self, "_on_signal_forwarded"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_signal_forwarded():
	inventory_menu.visible = !inventory_menu.visible
	
