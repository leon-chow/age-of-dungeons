extends Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
"""
Pathfinding:
	1. Represent dungeon as a 2D grid
	2. Check if the player is visible/within detection range
	3. AStar2D class
"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
