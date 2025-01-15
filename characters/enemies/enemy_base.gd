extends CharacterBody2D

class_name Enemy

@onready var player: CharacterBody2D = $"../Player"

var sleepTimer = 30
var vectorDiff = Vector2(0,0)
var isDetectingPlayer: bool = false;
var direction = "up";
var state = "patrol";

var movementUD: int = 0;
var movementLR: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = "chase";

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not GameManager.isPlayerTurn:
		""" 
			Movement will be based on these things:
				1. On spawn, make the enemy asleep
				2. When awoken, make the enemy patrol
				3. On player detection, make the enemy chase
					3.a. If player is raycasted, make the enemy attack
				4. On player detection lost, set the enemy back to patrol
		
		"""
		if state == "patrol":
			patrol();
		elif state == "chase":
			chase();
		elif state == "sleep":
			sleep();
	move_and_slide()

func calculate_movement(movementLR: int, movementUD: int) -> void:
	self.position.x = round(self.position.x + movementLR);
	self.position.y = round(self.position.y + movementUD);
	GameManager.isPlayerTurn = true;
	GameManager.turnCount += 1;
	movementLR = 0;
	movementUD = 0;
	print("player pos", player.global_position)
	print("enemy pos", self.global_position)
	
func patrol() -> void:		
	var movementUD: int = 0;
	var movementLR: int = 0;
	if not $RayCastLeft.is_colliding():
		movementUD = 0;
		movementLR = -16;
		calculate_movement(movementLR, movementUD)
	elif not $RayCastRight.is_colliding():
		movementUD = 0;
		movementLR = 16;
		calculate_movement(movementLR, movementUD)
	elif not $RayCastDown.is_colliding():
		movementLR = 0;
		movementUD = 16;
		calculate_movement(movementLR, movementUD)
	elif not $RayCastUp.is_colliding():
		movementLR = 0;
		movementUD = -16;
		calculate_movement(movementLR, movementUD)
	else:
		state = "chase"
		
func isAdjacent(vectorDiff: Vector2) -> bool:
	return abs(vectorDiff.x) <= GameManager.tileSize and abs(vectorDiff.y) <= GameManager.tileSize;
	
func chase() -> void:
	var vectorDiff = Vector2(player.global_position - self.global_position)
	if isAdjacent(vectorDiff):
		attack()
	else:
		if not $RayCastLeft.is_colliding() and vectorDiff.x < 0:
			movementLR = -16;
		elif not $RayCastRight.is_colliding() and vectorDiff.x > 0:
			movementLR = 16;
		if not $RayCastDown.is_colliding() and vectorDiff.y > 0:
			movementUD = 16;
		elif not $RayCastUp.is_colliding() and vectorDiff.y < 0:
			movementUD = -16;
	calculate_movement(movementLR, movementUD)
	GameManager.isPlayerTurn = true;
	
func sleep() -> void:
	pass
	
func attack() -> void:
	print("attacking...");
