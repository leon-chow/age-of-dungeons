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
		var atlasTexture = AtlasTexture.new();
		atlasTexture.atlas = item.itemTexture
		atlasTexture.region = item.textureRegion;
		item_icon.texture = atlasTexture;
		item_quantity.text = "1";
	else:
		item_icon.texture = null;
		item_quantity.text = "";
