extends CharacterBody2D


const movement = 4.0

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var leftRightDirection := Input.get_axis("ui_left", "ui_right")
	var upDownDirection := Input.get_axis("ui_up", "ui_down")
	if leftRightDirection or upDownDirection:
		position.x += leftRightDirection * movement
		position.y += upDownDirection * movement

	move_and_slide()
