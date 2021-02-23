class_name Zombie
extends RigidBody2D

var target
#export (PackedScene) var dead_zomb := preload("res://Scn/Actors/DeadZombie.tscn")
var hp := 5
var speed := 100


func _ready() -> void:
	add_to_group("Enemies")

func _physics_process(delta):
	if is_instance_valid(target):
		look_at(target.global_position)
#		set_applied_force(Vector2.RIGHT.rotated(rotation) * 50)
#		apply_impulse(Vector2.ZERO, Vector2.RIGHT.rotated(rotation))
		position += Vector2.RIGHT.rotated(rotation) * delta * speed

func dmg(amt: int) -> void:
	hp -= amt
	if hp <= 0:
		queue_free()
#		var dead_zombie = dead_zomb.instance()
#		dead_zombie.position = position
#		dead_zombie.rotation = rotation
#		get_parent().add_child(dead_zombie)
#		dead_zombie.set_physics_process(true)

