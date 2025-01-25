extends Item;

var movementUD: int = 0;
var movementLR: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hpRestoration = 20;
	self.consumable = true;
	self.itemName = "Fruit";
	super();
