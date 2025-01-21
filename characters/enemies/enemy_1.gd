extends Enemy;

var movementUD: int = 0;
var movementLR: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.level = 1;
	self.hp = 10;
	self.atk = 4;
	self.def = 1;
	self.matk = 1;
	self.mdef = 1;
	self.speed = 5;
	self.enemyExp = 10;
	super();

func _on_play_idle() -> void:
	animation.play("idle");
