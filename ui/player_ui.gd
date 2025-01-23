extends GridContainer

@onready var health_bar: ProgressBar = $VBoxContainer/HealthBar
@onready var energy_bar: ProgressBar = $VBoxContainer/EnergyBar
@onready var player: CharacterBody2D = $"../../.."
@onready var hp_label: Label = $VBoxContainer/HealthBar/Label
@onready var energy_label: Label = $VBoxContainer/EnergyBar/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = player.hp;
	health_bar.max_value = player.maxHp;
	energy_bar.value = player.energy;
	energy_bar.max_value = player.energy;
	hp_label.text = "%d / %d" % [player.hp, player.maxHp]
	energy_label.text = "%d / %d" % [player.energy, player.maxEnergy]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_bar.value = player.hp;
	energy_bar.value = player.energy;
	hp_label.text = "%d / %d" % [player.hp, player.maxHp]
	energy_label.text = "%d / %d" % [player.energy, player.maxEnergy]
