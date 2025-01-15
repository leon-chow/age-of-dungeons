extends CharacterBody2D

class_name Enemy

@onready var player: CharacterBody2D = $"../Player"

var sleepTimer = 30
var vectorDiff = Vector2(0,0)
var movementUD: float = 0;
var movementLR: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("enemy ready") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not GameManager.isPlayerTurn:
		print("player pos", player.global_position)
		print("enemy pos", self.global_position)
		var vectorDiff = Vector2(player.global_position - self.global_position)
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
	self.position.x = round(self.position.x + movementLR);
	self.position.y = round(self.position.y + movementUD);
	GameManager.isPlayerTurn = true;
	GameManager.turnCount += 1;
	
func patrol() -> void:
	pass
	
func chase() -> void:
	pass
	
func sleep() -> void:
	pass
