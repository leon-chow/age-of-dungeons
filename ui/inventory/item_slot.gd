extends ColorRect;

@onready var item_icon: TextureRect = $ItemIcon
@onready var item_quantity: Label = $ItemQuantity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display_item(item):
	if item:
		item_icon.texture = load("res://assets/sprites/%s" % item.icon);
		if item.stackable:
			item_quantity.text = str(item.quantity)
		else:
			item_quantity.text = ""
	else:
		item_icon.texture = null;
		item_quantity.text = "";
