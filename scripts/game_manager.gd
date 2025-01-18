extends Node

signal playerTurn(isPlayerTurn)
var isPlayerTurn = true;

var turnCount: int = 1
var tileSize: int = 16
var gridOffset: Vector2 = Vector2(8, 10)

var map = [[]]


func _on_player_turn(isPlayerTurn) -> void:
	isPlayerTurn = isPlayerTurn;
