extends Button

@onready var inventoryBtn: Button = $"."

const cols = 4;
const rows = 5;
var slots = rows * cols;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventoryBtn.pressed.connect(self._button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _button_pressed():
	print("Pressed!");
	
func add_item(index, item):
	pass
	
func remove_item(index):
	pass
	
func set_item_quantity(index, amount):
	pass
