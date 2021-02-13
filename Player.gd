extends Area2D

var speed = 2

func _physics_process(delta):
	position += speed * Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()
	
	look_at(get_global_mouse_position())
