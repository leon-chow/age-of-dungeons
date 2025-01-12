extends CharacterBody2D

@onready var player: CharacterBody2D = $"../Player"

const movement = 16.0
var vectorDiff = Vector2(0,0)
var direction
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vectorDiff = Vector2(player.global_position - global_position).normalized() * movement
	
"""
Pathfinding:
	1. Represent dungeon as a 2D grid
	2. Check if the player is visible/within detection range
	3. AStar2D class
"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not GameManager.isPlayerTurn:
		if not $RayCastLeft.is_colliding():
			position.x -= movement
			GameManager.isPlayerTurn = true
			GameManager.turnCount += 1
		elif not $RayCastRight.is_colliding():
			position.x += movement
			GameManager.isPlayerTurn = true
			GameManager.turnCount += 1
		elif not $RayCastDown.is_colliding():
			position.y += movement
			GameManager.isPlayerTurn = true
			GameManager.turnCount += 1
		elif not $RayCastUp.is_colliding():
			position.y -= movement
			GameManager.isPlayerTurn = true
			GameManager.turnCount += 1
		move_and_slide()
