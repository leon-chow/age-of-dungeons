extends CharacterBody2D;

@onready var animation: AnimatedSprite2D = $Animation
@onready var enemy: CharacterBody2D = $"../Enemy"

@onready var raycasts: Array = [$RayCastLeft, $RayCastUp, $RayCastRight, $RayCastDown];

var directions = ["ui_left", "ui_up", "ui_right", "ui_down"];

var movementUD: int = 0;
var movementLR: int = 0;

var hp: int = 10
var atk: int = 1
var def: int = 1
var matk: int = 1
var mdef: int = 1

func _ready() -> void:
	print("player loaded")

func _physics_process(delta: float) -> void:
	if hp <= 0:
		animation.play("death");
		await get_tree().create_timer(3.0).timeout;
		if get_tree():
			get_tree().reload_current_scene()
	# Get the input direction and handle the movement/deceleration.
	if GameManager.isPlayerTurn:
		if Input.is_action_just_pressed("ui_left"):
			if not $RayCastLeft.is_colliding():
				movementUD = 0;
				movementLR = -16;
				calculate_movement(movementLR, movementUD)
			else:
				if $RayCastLeft.get_collider().get_name() == "Enemy":
					attack(enemy)
		elif Input.is_action_just_pressed("ui_right"): 
			if not $RayCastRight.is_colliding():
				movementUD = 0;
				movementLR = 16;
				calculate_movement(movementLR, movementUD)
			else:
				if $RayCastRight.get_collider().get_name() == "Enemy":
					attack(enemy)
		elif Input.is_action_just_pressed("ui_down"):
			if not $RayCastDown.is_colliding():
				movementLR = 0;
				movementUD = 16;
				calculate_movement(movementLR, movementUD)
			else:
				if $RayCastDown.get_collider().get_name() == "Enemy":
					attack(enemy)
		elif Input.is_action_just_pressed("ui_up"):
			if not $RayCastUp.is_colliding():
				movementLR = 0;
				movementUD = -16;
				calculate_movement(movementLR, movementUD)
			else:
				if $RayCastUp.get_collider().get_name() == "Enemy":
					attack(enemy)


func play_idle():
	animation.play("idle");	
func hurt(): 
	animation.play("hurt");
			
func calculate_movement(movementLR: int, movementUD: int) -> void:
	position.x = floor(position.x) + movementLR;
	position.y = floor(position.y) + movementUD;
	print("player pos: ", position);
	GameManager.turnCount += 1;
	_on_game_manager_player_turn(false);

func attack(enemy) -> void:
	print("you are attacking...");
	var damage = enemy.atk;
	enemy.hp -= damage;
	print(hp);
	_on_game_manager_player_turn(false);

func _on_game_manager_player_turn(isPlayerTurn: Variant) -> void:
	isPlayerTurn = isPlayerTurn;
