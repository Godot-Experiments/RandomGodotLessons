extends RigidBody2D
class_name Player

var speed := 2
#export (PackedScene) var bullet_s = preload("which scene???")

# This function runs every 1/60th of a second
func _physics_process(delta: float) -> void:
	position += speed * Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()
	
	var gmp := get_global_mouse_position()
	look_at(gmp)
	
	"""Implement shooting!"""
	# Vector2(1, 0).rotated(rotation) 
		# will give you an arrow from the player to where your mouse is
	# bullet_s.instance() will "spawn in" a bullet, but without a position or rotation
	
