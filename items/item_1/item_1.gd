extends Item;

var movementUD: int = 0;
var movementLR: int = 0;
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hpRestoration = 20;
	self.consumable = true;
	self.itemName = "Fruit";
	self.itemTexture = sprite_2d.texture;
	self.textureRegion = sprite_2d.region_rect;
	super();
