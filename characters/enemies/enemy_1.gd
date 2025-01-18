extends Enemy;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hp = 10;
	self.atk = 4;
	self.def = 1;
	self.matk = 1;
	self.mdef = 1;
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	
func patrol() -> void:
	super();
	
func attack(player) -> void:
	super(player);
	_on_player_turn(true);
	
func chase() -> void:
	super();

func _on_player_turn(isPlayerTurn: Variant) -> void:
	isPlayerTurn = isPlayerTurn;
