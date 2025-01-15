extends CharacterBody2D;

var movementUD: float = 0;
var movementLR: float = 0;

func _ready() -> void:
	print(global_position);
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	if GameManager.isPlayerTurn:
		if Input.is_action_just_pressed("ui_left") and not $RayCastLeft.is_colliding():
			movementUD = 0;
			movementLR = -16.0;
			calculate_movement(movementLR, movementUD)
		elif Input.is_action_just_pressed("ui_right") and not $RayCastRight.is_colliding():
			movementUD = 0;
			movementLR = 16.0;
			calculate_movement(movementLR, movementUD)
		elif Input.is_action_just_pressed("ui_down") and not $RayCastDown.is_colliding():
			movementLR = 0;
			movementUD = 16.0;
			calculate_movement(movementLR, movementUD)
		elif Input.is_action_just_pressed("ui_up") and not $RayCastUp.is_colliding():
			movementLR = 0;
			movementUD = -16.0;
			calculate_movement(movementLR, movementUD)
		move_and_slide()
	
func calculate_movement(movementLR: float, movementUD: float) -> void:
	position.x = round(position.x + movementLR);
	position.y = round(position.y + movementUD);
	GameManager.isPlayerTurn = false;
	GameManager.turnCount += 1;
