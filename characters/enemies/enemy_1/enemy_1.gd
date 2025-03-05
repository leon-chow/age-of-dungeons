extends Enemy;

var movementUD: int = 0;
var movementLR: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.level = 1;
	self.hp = 10;
	self.atk = 5;
	self.def = 2;
	self.matk = 2;
	self.mdef = 2;
	self.speed = 5;
	self.enemyExp = 10;
	self.id = randi() % 10000000 + 1;
	self.name = "Orc" + str(GameManager.enemySpawnCounter);
	super();

func _on_play_idle() -> void:
	animation.play("idle");
