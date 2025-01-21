extends Node

var isPlayerTurn = true;
@onready var player: CharacterBody2D = $"../Player"

var turnCount: int = 1
var tileSize: int = 16
var gridOffset: Vector2 = Vector2(8, 10)

var enemyTurnOrder: Array[Enemy] = [];

var map = [[]];

func sort_speed(enemyA: Enemy, enemyB: Enemy) -> bool: 
	return enemyA.speed > enemyB.speed;

func _on_player_turn_ended(isPlayerTurn) -> void:
	print(isPlayerTurn);
	if not isPlayerTurn:
		for enemy: Enemy in get_parent().get_node("Enemies").get_children():
			enemyTurnOrder.append(enemy)
			
		enemyTurnOrder.sort_custom(sort_speed);
		
		if enemyTurnOrder.size() > 0 and is_instance_valid(enemyTurnOrder[0]):
			enemyTurnOrder[0].isEnemyTurn = true;
		else:
			GameManager.isPlayerTurn = true
			
func _on_enemy_killed(enemy: Enemy) -> void:
	player.gain_exp(enemy.enemyExp);
	enemyTurnOrder = [];
	for currentEnemy: Enemy in get_parent().get_node("Enemies").get_children():
		enemyTurnOrder.append(enemy)
	enemyTurnOrder.sort_custom(sort_speed);
	print(enemyTurnOrder);
		
	if enemyTurnOrder.size() > 0:
		GameManager.isPlayerTurn = true

func _on_enemy_turn_ended() -> void:
	enemyTurnOrder[0].isEnemyTurn = false;
	enemyTurnOrder.pop_front()
	if enemyTurnOrder.size() > 0 and is_instance_valid(enemyTurnOrder[0]):
		enemyTurnOrder[0].isEnemyTurn = true;
	else:
		print("Player's turn!");
		GameManager.isPlayerTurn = true;
