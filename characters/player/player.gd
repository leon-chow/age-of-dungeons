extends CharacterBody2D;

var movementUD: int = 0;
var movementLR: int = 0;

var hp: int = 10;
var atk: int = 1;
var def: int = 1;
var matk: int = 1;
var mdef: int = 1;
@onready var animation: AnimatedSprite2D = $Animation

func _ready() -> void:
	print(global_position);

func _physics_process(delta: float) -> void:
	if hp <= 0:
		animation.play("death");
		await get_tree().create_timer(3.0).timeout;
		if get_tree():
			get_tree().reload_current_scene()
	# Get the input direction and handle the movement/deceleration.
	if GameManager.isPlayerTurn:
		if Input.is_action_just_pressed("ui_left") and not $RayCastLeft.is_colliding():
			movementUD = 0;
			movementLR = -16;
			calculate_movement(movementLR, movementUD)
		elif Input.is_action_just_pressed("ui_right") and not $RayCastRight.is_colliding():
			movementUD = 0;
			movementLR = 16;
			calculate_movement(movementLR, movementUD)
		elif Input.is_action_just_pressed("ui_down") and not $RayCastDown.is_colliding():
			movementLR = 0;
			movementUD = 16;
			calculate_movement(movementLR, movementUD)
		elif Input.is_action_just_pressed("ui_up") and not $RayCastUp.is_colliding():
			movementLR = 0;
			movementUD = -16;
			calculate_movement(movementLR, movementUD)
			
func calculate_movement(movementLR: int, movementUD: int) -> void:
	position.x = floor(position.x) + movementLR;
	position.y = floor(position.y) + movementUD;
	print("player pos: ", position);
	GameManager.isPlayerTurn = false;
	GameManager.turnCount += 1;
