extends Area2D

class_name Item
@onready var player: CharacterBody2D = $"../../Player"

func _ready():
	pass

func _physics_process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print(body);
	if body.name == "Player":
		if player.inventory.size() < player.bagSize:
			player.pick_up_item(self.name);
			player.heal(20);
			queue_free()
		else:
			print("Too many items!");
	else:
		print("Something else walked over")
