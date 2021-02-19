class_name Bullet
extends RigidBody2D

var rot: float = 0
export (PackedScene) var spray_s := preload("res://Scn/Spray.tscn")
func _on_Timer_timeout() -> void:
	queue_free()

func set_rot(angle: float) -> void:
	rotation = angle
	rot = angle

func _on_Bullet_body_entered(body):
	if body.is_in_group("Enemies"):
		body.queue_free()

		
	var spray = spray_s.instance()
	spray.global_rotation = rot - PI
	spray.emitting = true
	spray.position = position
	get_parent().add_child(spray)
	queue_free()
