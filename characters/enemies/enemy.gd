extends CharacterBody2D;

class_name Enemy;

@onready var player: CharacterBody2D = $"../../Player"

var sleepTimer = 30
var isDetectingPlayer: bool = false;
var state = "patrol";
var isEnemyTurn: bool = false;
signal enemy_turn_ended

var level: int;
var hp: int;
var atk: int;
var def: int;
var matk: int;
var mdef: int;
var speed: int;
var enemyExp: int;

@onready var animation: AnimatedSprite2D = $Animation;
@onready var health_bar: ProgressBar = $HealthBar;

signal on_death(enemy);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_death.connect(_on_death)
	health_bar.value = hp;
	health_bar.max_value = hp;
	print("enemy ready");
	state = "chase";	

func act() -> void:
	if not GameManager.isPlayerTurn and hp > 0:
		print(name, "'s turn");
		""" 
			Movement will be based on these things:
				1. On spawn, make the enemy asleep
				2. When awoken, make the enemy patrol
				3. On player detection, make the enemy chase
					3.a. If player is raycasted, make the enemy attack
				4. On player detection lost, set the enemy back to patrol
		
		"""
		if state == "chase":
			chase();
		elif state == "sleep":
			sleep();
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	health_bar.value = hp;
	if (hp <= 0):
		await get_tree().create_timer(0.2).timeout;
		queue_free();
		_on_death();
		print(self.name, "is dying...");

func calculate_movement(vectorMovement) -> void:
	position = round(position + vectorMovement);
	if vectorMovement.x == GameManager.tileSize:
		animation.flip_h = false;
	elif vectorMovement.x == -GameManager.tileSize:
		animation.flip_h = true;
	GameManager.turnCount += 1;
	move_and_slide();
	end_turn();
		
func isAdjacent(vectorDiff: Vector2) -> bool:
	return snappedi(abs(vectorDiff.x), GameManager.tileSize) <= GameManager.tileSize and snappedi(abs(vectorDiff.y), GameManager.tileSize) <= GameManager.tileSize;
	
func chase() -> void:
	var vectorDiff = Vector2(player.global_position - self.global_position)
	var vectorMovement = Vector2.ZERO;
	if isAdjacent(vectorDiff):
		attack();
	else:
		# TODO: Figure out how to stop clipping, which may be taken care of by path finding, and then fix enemies from colliding diagonally with each other
		if vectorDiff.x >= 0 and vectorDiff.x <= 1:
			vectorMovement.x = 0;
		elif not $RayCastLeft.is_colliding() and vectorDiff.x < 0:
			vectorMovement.x = -GameManager.tileSize;
		elif not $RayCastRight.is_colliding() and vectorDiff.x > 0:
			vectorMovement.x = GameManager.tileSize;
		if vectorDiff.y >= 0 and vectorDiff.y <= 1:
			vectorMovement.y = 0;
		elif not $RayCastDown.is_colliding() and vectorDiff.y > 0:
			vectorMovement.y = GameManager.tileSize;
		elif not $RayCastUp.is_colliding() and vectorDiff.y < 0:
			vectorMovement.y = -GameManager.tileSize;
		calculate_movement(vectorMovement);
	
func sleep() -> void:
	pass
	
func attack() -> void:
	animation.play("attack")
	print(name, " is attacking...");
	var damage = self.atk;
	player.hp -= damage;
	print("player HP: ", player.hp);
	player.hurt();
	end_turn();
	
func end_turn():
	isEnemyTurn = false;
	enemy_turn_ended.emit();
	
func _on_death():
	animation.play("death");
	on_death.emit(self);
