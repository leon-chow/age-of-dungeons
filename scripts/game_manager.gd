extends Node

var isPlayerTurn = true;

var turnCount: int = 1
var tileSize: int = 16
var gridOffset: Vector2 = Vector2(8, 10)

var enemyTurnOrder = [];

var numOfEnemies = 0;
var numOfEnemiesMoved = 0;

var map = [[]];

func _on_player_turn_ended(isPlayerTurn) -> void:
	if not isPlayerTurn:
		for enemy: Enemy in get_parent().get_node("Enemies").get_children():
			enemy.isEnemyTurn = true;
# Revisit this, need a way to keep track of all turns and then need a loader to perform turns one at a time instead of all at once
func _on_enemy_turn_ended() -> void:
	GameManager.numOfEnemies = get_parent().get_node("Enemies").get_children().size();
	print("enemy moved...")
	numOfEnemiesMoved += 1;
	print(numOfEnemies);
	if numOfEnemiesMoved == GameManager.numOfEnemies:
		numOfEnemiesMoved = 0;
		GameManager.isPlayerTurn = true;
