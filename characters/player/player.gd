extends CharacterBody2D;

@onready var animation: AnimatedSprite2D = $Animation

@onready var raycasts: Array = [$RayCastLeft, $RayCastUp, $RayCastRight, $RayCastDown];

signal player_turn_ended

var directions = ["ui_left", "ui_up", "ui_right", "ui_down"];

var movementUD: int = 0;
var movementLR: int = 0;

var vectorMovement = Vector2.ZERO

var hp: int = 100;
var atk: int = 1;
var def: int = 1;
var matk: int = 1;
var mdef: int = 1;

func _ready() -> void:
	player_turn_ended.connect(end_turn)
	print("player loaded");

func _physics_process(delta: float) -> void:
	if hp <= 0:
		animation.play("death");
		await get_tree().create_timer(3.0).timeout;
		if get_tree():
			get_tree().reload_current_scene();
	# Get the input direction and handle the movement/deceleration.
	if GameManager.isPlayerTurn:
		if Input.is_action_just_pressed("ui_left"):
			if not $RayCastLeft.is_colliding():
				vectorMovement = Vector2(-GameManager.tileSize, 0);
				calculate_movement(vectorMovement, delta);
			else:
				if $RayCastLeft.get_collider().get_parent().get_name() == "Enemies":
					attack($RayCastLeft.get_collider());
		elif Input.is_action_just_pressed("ui_right"): 
			if not $RayCastRight.is_colliding():
				vectorMovement = Vector2(GameManager.tileSize, 0);
				calculate_movement(vectorMovement, delta);
			else:
				if $RayCastRight.get_collider().get_parent().get_name() == "Enemies":
					attack($RayCastRight.get_collider())
		elif Input.is_action_just_pressed("ui_down"):
			if not $RayCastDown.is_colliding():
				vectorMovement = Vector2(0, GameManager.tileSize);
				calculate_movement(vectorMovement, delta);
			else:
				if $RayCastDown.get_collider().get_parent().get_name() == "Enemies":
					attack($RayCastDown.get_collider())
		elif Input.is_action_just_pressed("ui_up"):
			if not $RayCastUp.is_colliding():
				vectorMovement = Vector2(0, -GameManager.tileSize);
				calculate_movement(vectorMovement, delta);
			else:
				if $RayCastUp.get_collider().get_parent().get_name() == "Enemies":
					attack($RayCastUp.get_collider());


func play_idle():
	animation.play("idle");	
func hurt(): 
	animation.play("hurt");
			
func calculate_movement(vectorMovement, delta: float) -> void:
	position = round(position + vectorMovement);
	GameManager.turnCount += 1;
	move_and_slide();
	end_turn();
	
func end_turn():
	GameManager.isPlayerTurn = false;
	player_turn_ended.emit(false);

func attack(enemy) -> void:
	print("you are attacking ", enemy.name);
	var damage = enemy.atk;
	enemy.hp -= damage;
	print(enemy.name, " HP: ", enemy.hp);
	end_turn();
