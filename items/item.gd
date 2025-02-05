extends Area2D

class_name Item
@onready var player: CharacterBody2D = $"../../Player"

var itemName := "test";
var hpRestoration := 0;
var energyRestoration := 0;
var atkIncrease := 0;
var defIncrease := 0;
var strIncrease := 0;
var matkIncrease := 0;
var mdefIncrease := 0;
var speedIncrease := 0;
var damage := 0;
var consumable := true;
var throwable := false; 
var effect := "";
var itemTexture = AtlasTexture;
var textureRegion = Rect2();
var quantity := 1;

func _ready():
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if player.inventory.size() < player.bagSize:
			player.pick_up_item(self);
			queue_free()
		else:
			print("Too many items!");
	else:
		print("Something else walked over")
