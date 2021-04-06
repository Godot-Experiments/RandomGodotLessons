extends RigidBody2D

var acc
var speed := 24
var jump_force := 800
var downwards_force := 50

export (PackedScene) var box

func _ready() -> void:
	linear_damp = .2

func _physics_process(delta: float) -> void:
	acc = (Input.get_action_strength("sprint") + 1) * speed * Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		0
	).normalized()
	
	apply_central_impulse(acc)
	
	if Input.is_action_just_pressed("ui_up"):
		apply_central_impulse(Vector2(0, -jump_force))
		
	apply_central_impulse(Vector2(0, downwards_force * Input.get_action_strength("ui_down")))
	
	if Input.is_action_pressed("stop"):
		apply_central_impulse(-linear_velocity)
	
	if Input.is_action_just_pressed("rclick"):
		var b = box.instance()
		b.position = get_global_mouse_position()
		get_parent().add_child(b)
		
