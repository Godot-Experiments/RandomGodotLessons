class_name Zombie
extends RigidBody2D

var target: Player

func _ready() -> void:
	add_to_group("Enemies")

func _physics_process(delta):
	if is_instance_valid(target):
		look_at(target.global_position)
#		set_applied_force(Vector2.RIGHT.rotated(rotation) * 50)
#		apply_impulse(Vector2.ZERO, Vector2.RIGHT.rotated(rotation))
		position += Vector2.RIGHT.rotated(rotation)


#func _on_Zombie_body_entered(body):

