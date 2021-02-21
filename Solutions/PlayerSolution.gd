extends RigidBody2D
#class_name Player

var speed := 2
onready var trace := $Muzzle/Trace
export (PackedScene) var bullet_s = preload("res://Scn/Bullet.tscn")


func _physics_process(delta: float) -> void:
	position += speed * Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()
	
	var gmp := get_global_mouse_position()
	look_at(gmp)
	if Input.is_action_just_pressed("fire"):
		var bullet = bullet_s.instance()
		get_parent().add_child(bullet)
		bullet.set_rot(rotation)
		bullet.global_position = $Muzzle.global_position
		bullet.apply_impulse(Vector2.ZERO, Vector2.RIGHT.rotated(rotation) * 500)
		
		# extra visual stuff
#		trace.show()
#		trace.points[1] = trace.get_local_mouse_position()
#		$Muzzle/Trace/Light2D.position = trace.points[1] * 2 / 3
#		$Muzzle/Trace/Light2D.scale = Vector2(trace.points[1].length() / 100, 1)
#		draw_line($Muzzle.position, gmp, Color.yellow)
#	else:
#		trace.hide()
