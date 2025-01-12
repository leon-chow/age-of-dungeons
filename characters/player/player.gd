extends CharacterBody2D

const movement = 16.0

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if GameManager.isPlayerTurn:
		if Input.is_action_just_pressed("ui_left") and not $RayCastLeft.is_colliding():
			position.x -= movement
			GameManager.isPlayerTurn = false;
			GameManager.turnCount += 1;
			print(GameManager.turnCount)
		if Input.is_action_just_pressed("ui_right") and not $RayCastRight.is_colliding():
			position.x += movement
			GameManager.isPlayerTurn = false;
			GameManager.turnCount += 1;
			print(GameManager.turnCount)
		if Input.is_action_just_pressed("ui_down") and not $RayCastDown.is_colliding():
			position.y += movement
			GameManager.isPlayerTurn = false;
			GameManager.turnCount += 1;
			print(GameManager.turnCount)
		if Input.is_action_just_pressed("ui_up") and not $RayCastUp.is_colliding():
			position.y -= movement
			GameManager.isPlayerTurn = false;
			GameManager.turnCount += 1;
			print(GameManager.turnCount)
		move_and_slide()
	
