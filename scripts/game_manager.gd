extends Node

@onready var tooltip: ColorRect = $"../UI/Tooltip"
@onready var player: CharacterBody2D = $"../Player"
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
var enemy_scene = preload("res://characters/enemies/enemy_1/enemy1.tscn");

var isPlayerTurn = true;

var turnCount: int = 1
var tileSize: int = 16
var mapOffset: Vector2 = Vector2(8, 10)
var floor: int = 1;
var enemySpawnTimer: int = 0;
var maxSpawnAttempts := 10;
var enemySpawnCounter := 1;

const ATLAS_WALL_COORDS = Vector2i(6, 1)

var enemyTurnOrder: Array[Enemy] = [];

var map = [[]];

func _ready() -> void:
	enemySpawnTimer = randi() % 30 + 1
	
# Enemy behaviour
func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate();
	var spawn_position = Vector2.ZERO;
	for i in range(maxSpawnAttempts):
		spawn_position = snapped(Vector2(randi_range(0, 100), randi_range(0, 100)), Vector2(16, 16)) + mapOffset
		
		if is_valid_spawn_position(spawn_position):
			break
			
	if spawn_position != Vector2.ZERO:
		enemy.global_position = spawn_position
	
		get_parent().get_node("Enemies").add_child(enemy);
		enemy.on_death.connect(player.gain_exp)
		enemySpawnCounter += 1;

func is_valid_spawn_position(position) -> bool:
	var tile_coords = tile_map_layer.local_to_map(position)
	var cell_atlas_coords = tile_map_layer.get_cell_atlas_coords(tile_coords)
	if cell_atlas_coords != ATLAS_WALL_COORDS:
		return true
	return false;

func should_spawn_enemy() -> void:
	enemySpawnTimer -= 1;
	
	if enemySpawnTimer <= 0:
		enemySpawnTimer = randi() % 30 + 1
		spawn_enemy();

func sort_speed(enemyA: Enemy, enemyB: Enemy) -> bool: 
	return enemyA.speed > enemyB.speed;
	
func perform_enemy_turns() -> void:
	for enemy: Enemy in get_parent().get_node("Enemies").get_children():
		enemyTurnOrder.append(enemy);
			
		enemyTurnOrder.sort_custom(sort_speed);
		
	for enemy: Enemy in enemyTurnOrder:
		if is_instance_valid(enemy):
			enemy.act();
		
# Signals
func _on_player_turn_ended(isPlayerTurn) -> void:
	enemyTurnOrder = [];
	if not isPlayerTurn:
		await perform_enemy_turns();
		await should_spawn_enemy()
		GameManager.isPlayerTurn = true;
			
func _on_enemy_killed(enemy: Enemy) -> void:
	player.gain_exp(enemy.enemyExp);
