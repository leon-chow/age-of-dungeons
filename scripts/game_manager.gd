extends Node

@onready var tooltip: ColorRect = $"../UI/Tooltip"
@onready var player: CharacterBody2D = $"../Player"
var enemy_scene = preload("res://characters/enemies/enemy_1/enemy1.tscn");

var isPlayerTurn = true;

var turnCount: int = 1
var tileSize: int = 16
var mapOffset: Vector2 = Vector2(8, 10)
var floor: int = 1;
var enemySpawnTimer: int = 0;

var enemyTurnOrder: Array[Enemy] = [];

var map = [[]];

func _ready() -> void:
	enemySpawnTimer = randi() % 30 + 1

func sort_speed(enemyA: Enemy, enemyB: Enemy) -> bool: 
	return enemyA.speed > enemyB.speed;
	
func perform_enemy_turns() -> void:
	for enemy: Enemy in get_parent().get_node("Enemies").get_children():
		enemyTurnOrder.append(enemy);
			
		enemyTurnOrder.sort_custom(sort_speed);
		
	for enemy: Enemy in enemyTurnOrder:
		if is_instance_valid(enemy):
			enemy.act();
			
func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate();
	var spawn_position = snapped(Vector2(randi_range(0, 100), randi_range(0, 100)), Vector2(16, 16)) + mapOffset
	enemy.global_position = spawn_position
	
	get_parent().get_node("Enemies").add_child(enemy);
	enemy.on_death.connect(player.gain_exp)

func should_spawn_enemy() -> void:
	enemySpawnTimer -= 1;
	
	if enemySpawnTimer <= 0:
		enemySpawnTimer = randi() % 30 + 1
		spawn_enemy();

func _on_player_turn_ended(isPlayerTurn) -> void:
	enemyTurnOrder = [];
	if not isPlayerTurn:
		await perform_enemy_turns();
		await should_spawn_enemy()
		GameManager.isPlayerTurn = true;
			
func _on_enemy_killed(enemy: Enemy) -> void:
	player.gain_exp(enemy.enemyExp);
