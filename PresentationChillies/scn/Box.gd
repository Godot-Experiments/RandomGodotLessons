extends RigidBody2D



func _on_Control_gui_input(event: InputEvent):
	if event.is_action("click"):
		queue_free()


func _on_Timer_timeout():
	queue_free()
