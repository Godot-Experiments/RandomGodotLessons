extends Camera2D

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_WHEEL_UP:
			zoom *= .9
		elif event.button_index == BUTTON_WHEEL_DOWN:
			zoom *= 1.1
#		elif event.button_index == BUTTON_WHEEL_DOWN and event.is_pressed():
			

func _physics_process(delta):
	offset += Vector2(
		Input.get_action_strength("cam_right") - Input.get_action_strength("cam_left"),
		Input.get_action_strength("cam_down") - Input.get_action_strength("cam_up")
	).normalized() * 8
	if Input.is_action_just_pressed("stop"):
		offset = Vector2(0, -250)
