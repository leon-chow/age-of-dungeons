extends CharacterBody2D;

class_name Enemy;

@onready var player: CharacterBody2D = $"../Player"

var sleepTimer = 30
var vectorDiff = Vector2(0,0)
var isDetectingPlayer: bool = false;
var state = "patrol";

var movementUD: int = 0;
var movementLR: int = 0;

var hp: int
var atk: int
var def: int
var matk: int
var mdef: int

@onready var animation: AnimatedSprite2D = $Animation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("enemy ready");
	state = "chase";

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (hp <= 0):
		animation.play("death");
		await get_tree().create_timer(1.0).timeout;
		queue_free()
	elif not GameManager.isPlayerTurn:
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
	position.x = floor(position.x) + movementLR;
	position.y = floor(position.y) + movementUD;
	print("enemy pos: ", position);
	GameManager.turnCount += 1;

func patrol() -> void:		
	var movementUD: int = 0;
	var movementLR: int = 0;
	if not $RayCastLeft.is_colliding():
		movementLR = -16;
		calculate_movement(movementLR, movementUD);
	elif not $RayCastRight.is_colliding():
		movementLR = 16;
		calculate_movement(movementLR, movementUD);
	elif not $RayCastDown.is_colliding():
		movementUD = 16;
		calculate_movement(movementLR, movementUD);
	elif not $RayCastUp.is_colliding():
		movementUD = -16;
		calculate_movement(movementLR, movementUD);
	else:
		state = "chase";
		
func isAdjacent(vectorDiff: Vector2) -> bool:
	return snappedi(abs(vectorDiff.x), GameManager.tileSize) <= GameManager.tileSize and snappedi(abs(vectorDiff.y), GameManager.tileSize) <= GameManager.tileSize;
	
func chase() -> void:
	var vectorDiff = Vector2(player.global_position - self.global_position)
	if isAdjacent(vectorDiff):
		attack(player);
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
	
func sleep() -> void:
	pass
	
func attack(player) -> void:
	print("you are attacking...");
	var damage = player.atk;
	player.hp -= damage;
	print(player.hp);
