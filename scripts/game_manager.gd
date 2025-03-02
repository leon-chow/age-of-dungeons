extends Node

@onready var tooltip: ColorRect = $"../UI/Tooltip"
@onready var player: CharacterBody2D = $"../Player"

var isPlayerTurn = true;

var turnCount: int = 1
var tileSize: int = 16
var gridOffset: Vector2 = Vector2(8, 10)
var floor: int = 1;

var enemyTurnOrder: Array[Enemy] = [];

var map = [[]];

func sort_speed(enemyA: Enemy, enemyB: Enemy) -> bool: 
	return enemyA.speed > enemyB.speed;

func _on_player_turn_ended(isPlayerTurn) -> void:
	enemyTurnOrder = [];
	if not isPlayerTurn:
		for enemy: Enemy in get_parent().get_node("Enemies").get_children():
			enemyTurnOrder.append(enemy)
			
		enemyTurnOrder.sort_custom(sort_speed);
		
		for enemy: Enemy in enemyTurnOrder:
			if is_instance_valid(enemy):
				enemy.act()
		
		GameManager.isPlayerTurn = true
			
func _on_enemy_killed(enemy: Enemy) -> void:
	player.gain_exp(enemy.enemyExp);
