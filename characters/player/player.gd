extends CharacterBody2D;

@onready var animation: AnimatedSprite2D = $Animation

@onready var raycasts: Array = [$RayCastLeft, $RayCastUp, $RayCastRight, $RayCastDown];
@onready var health_bar: ProgressBar = $HealthBar
@onready var hp_value: RichTextLabel = $HPValue

signal player_turn_ended

var directions = ["ui_left", "ui_up", "ui_right", "ui_down"];

var movementUD: int = 0;
var movementLR: int = 0;

var vectorMovement = Vector2.ZERO

var level: int = 1;
var energy: int = 100;
var hp: int = 100;
var maxHp: int = 100;
var atk: int = 5;
var def: int = 2;
var matk: int = 5;
var mdef: int = 2;
var playerExp: int = 0;
var expRequiredToLevel: int = 20;
var inventory: Array[String] = [];
var bagSize: int = 20;

func _ready() -> void:
	health_bar.max_value = hp;
	health_bar.value = hp;
	hp_value.text = str(health_bar.value) + "/" + str(maxHp);
	player_turn_ended.connect(end_turn)
	print("player loaded");

func _physics_process(delta: float) -> void:
	health_bar.value = hp;
	hp_value.text = str(health_bar.value) + "/" + str(maxHp);
	if hp <= 0:
		animation.play("death");
		await get_tree().create_timer(3.0).timeout;
		if get_tree():
			get_tree().reload_current_scene();
	# Get the input direction and handle the movement/deceleration.
	if GameManager.isPlayerTurn:
		if Input.is_action_just_pressed("ui_left"):
			animation.flip_h = true;
			if not $RayCastLeft.is_colliding():
				vectorMovement = Vector2(-GameManager.tileSize, 0);
				calculate_movement(vectorMovement, delta);
			else:
				if $RayCastLeft.get_collider().get_parent().get_name() == "Enemies":
					attack($RayCastLeft.get_collider());
				elif $RayCastLeft.get_collider().get_parent().get_name() == "Items":
					vectorMovement = Vector2(-GameManager.tileSize, 0);
					calculate_movement(vectorMovement, delta);
		elif Input.is_action_just_pressed("ui_right"): 
			animation.flip_h = false;
			if not $RayCastRight.is_colliding():
				vectorMovement = Vector2(GameManager.tileSize, 0);
				calculate_movement(vectorMovement, delta);
			else:
				if $RayCastRight.get_collider().get_parent().get_name() == "Enemies":
					attack($RayCastRight.get_collider())
				elif $RayCastRight.get_collider().get_parent().get_name() == "Items":
					vectorMovement = Vector2(GameManager.tileSize, 0);
					calculate_movement(vectorMovement, delta);
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
						
func _on_level_up():
	var levelUpAnimation = create_tween();
	improve_stats();
	self.playerExp -= expRequiredToLevel;
	level += 1;
	expRequiredToLevel = level * 20;
	
func improve_stats():
	maxHp += 20;
	hp += 20;
	atk += 5;
	def += 5;
	matk += 5;
	mdef += 5;
	
func pick_up_item(item): 
	inventory.append(item)
	print("inventory: ", inventory)

func play_idle():
	animation.play("idle");	

func hurt(): 
	if animation.animation == "idle":
		animation.play("hurt");
	
func gain_exp(expGained):
	playerExp += expGained;
	while (playerExp >= expRequiredToLevel):
		print("Leveled up!")
		_on_level_up();
		
func calculate_movement(vectorMovement, delta: float) -> void:
	position = round(position + vectorMovement);
	GameManager.turnCount += 1;
	move_and_slide();
	end_turn();
	
func end_turn():
	GameManager.isPlayerTurn = false;
	player_turn_ended.emit(false);

func heal(value) -> void:
	hp += value;
	hp = min(hp, maxHp);
	
func attack(enemy) -> void:
	animation.play("attack")
	print("you are attacking ", enemy.name);
	var damage = atk - enemy.def;
	enemy.hp -= max(damage, 1);
	print(enemy.name, " HP: ", enemy.hp);
	end_turn();
