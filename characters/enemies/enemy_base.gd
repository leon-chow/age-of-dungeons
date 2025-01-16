extends CharacterBody2D

class_name Enemy

@onready var player: CharacterBody2D = $"../Player"

var sleepTimer = 30
var vectorDiff = Vector2(0,0)
var isDetectingPlayer: bool = false;
var state = "patrol";

var movementUD: int = 0;
var movementLR: int = 0;

var hp: int = 100;
var atk: int = 5;
var def: int = 5;
var matk: int = 5;
var mdef: int = 5;


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
		if state == "chase":
			chase();
		elif state == "sleep":
			sleep();

func calculate_movement(movementLR: int, movementUD: int) -> void:
	self.position.x = floor(self.position.x) + movementLR;
	self.position.y = floor(self.position.y) + movementUD;
	GameManager.isPlayerTurn = true;
	GameManager.turnCount += 1;
	movementLR = 0;
	movementUD = 0;

func patrol() -> void:		
	var movementUD: int = 0;
	var movementLR: int = 0;
	if not $RayCastLeft.is_colliding():
		movementLR = -16;
		calculate_movement(movementLR, movementUD)
	elif not $RayCastRight.is_colliding():
		movementLR = 16;
		calculate_movement(movementLR, movementUD)
	elif not $RayCastDown.is_colliding():
		movementUD = 16;
		calculate_movement(movementLR, movementUD)
	elif not $RayCastUp.is_colliding():
		movementUD = -16;
		calculate_movement(movementLR, movementUD)
	else:
		state = "chase"
		
func isAdjacent(vectorDiff: Vector2) -> bool:
	return snappedi(abs(vectorDiff.x), GameManager.tileSize) <= GameManager.tileSize and snappedi(abs(vectorDiff.y), GameManager.tileSize) <= GameManager.tileSize;
	
func chase() -> void:
	var vectorDiff = Vector2(player.global_position - self.global_position)
	if isAdjacent(vectorDiff):
		attack();
	else:
		print(vectorDiff);
		print($RayCastUpLeft.is_colliding());
		if vectorDiff.x >= 0 and vectorDiff.x <= 1:
			movementLR = 0;
		elif not $RayCastLeft.is_colliding() and vectorDiff.x < 0:
			movementLR = -16;
		elif not $RayCastRight.is_colliding() and vectorDiff.x > 0:
			movementLR = 16;
		if vectorDiff.y >= 0 and vectorDiff.y <= 1:
			movementUD = 0;
		elif not $RayCastDown.is_colliding() and vectorDiff.y > 0:
			movementUD = 16;
		elif not $RayCastUp.is_colliding() and vectorDiff.y < 0:
			movementUD = -16;
		print("Enemy will move ", movementLR, " spots horizontally and ", movementUD, " spots vertically");
		calculate_movement(movementLR, movementUD)
		print("enemy pos: ", self.global_position)
		GameManager.isPlayerTurn = true;
	
func sleep() -> void:
	pass
	
func attack() -> void:
	print("attacking...");
	var damage = self.atk - player.def;
	player.
	player.hp -= damage;
	GameManager.isPlayerTurn = true;
