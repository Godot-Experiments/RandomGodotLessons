class_name Zombie
extends Area2D

var target: Area2D

func _physics_process(delta):
	if is_instance_valid(target):
		look_at(target.global_position)
		position += Vector2.RIGHT.rotated(rotation)
