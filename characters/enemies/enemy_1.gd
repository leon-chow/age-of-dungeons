extends CharacterBody2D

@onready var player: CharacterBody2D = $"../Player"

var vectorDiff = Vector2(0,0)
var movementUD: float = 0;
var movementLR: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
"""
Pathfinding:
	1. Represent dungeon as a 2D grid
	2. Check if the player is visible/within detection range
	3. AStar2D class
"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not GameManager.isPlayerTurn:
		print("player pos", player.global_position)
		print("enemy pos", global_position)
		var vectorDiff = Vector2(player.global_position - global_position)
		print(vectorDiff)
		if not $RayCastLeft.is_colliding():
			movementUD = 0;
			movementLR = -16.0;
			calculate_movement(movementLR, movementUD)
		elif not $RayCastRight.is_colliding():
			movementUD = 0;
			movementLR = 16.0;
			calculate_movement(movementLR, movementUD)
		elif not $RayCastDown.is_colliding():
			movementLR = 0;
			movementUD = 16.0;
			calculate_movement(movementLR, movementUD)
		elif not $RayCastUp.is_colliding():
			movementLR = 0;
			movementUD = -16.0;
			calculate_movement(movementLR, movementUD)
		move_and_slide()
	
func calculate_movement(movementLR: float, movementUD: float) -> void:
	position.x = round(position.x + movementLR);
	position.y = round(position.y + movementUD);
	GameManager.isPlayerTurn = true;
	GameManager.turnCount += 1;
