extends RigidBody2D
class_name Player

var speed := 200
export (PackedScene) var bullet_s = preload("res://Scn/Bullet.tscn")

var guns := {
	0 : [preload("res://Img/PNG/Soldier 1/soldier1_machine.png"), preload("res://Sfx/M4A1_Single-Kibblesbob-8540445.wav")], 
	1 : [preload("res://Img/PNG/Soldier 1/soldier1_gun.png"), preload("res://Sfx/Shotgun_Blast-Jim_Rogers-1914772763.wav")]
	}
var current_gun := 0
var spread := .1

onready var Firetime := $Firetime
onready var Gunfire := $Muzzle/Gunfire
onready var Cam := $Cam
onready var Anim := $Tween

var target


# This function runs every 1/60th of a second
func _physics_process(delta: float) -> void:
	var vel = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()
	if vel.length_squared() != 0 or Input.is_action_pressed("fire"):
		Engine.time_scale = 1
		Anim.interpolate_property(Cam, "zoom", Cam.zoom, Vector2(1,1), .2)
		Anim.start()
	else:
		Engine.time_scale = .25
		Anim.interpolate_property(Cam, "zoom", Cam.zoom, Vector2(.9,.9), .2)
		Anim.start()
	
	position += (Input.get_action_strength("sprint") + 1)* speed * delta * vel
	
	var gmp := get_global_mouse_position()
	look_at(gmp)
#	if target:
#		look_at(target.global_position)
	
	if (Input.is_action_pressed("fire")) and Firetime.is_stopped():
		if current_gun == 1:
			for i in range(7):
				fire()
			$Cam.start(0.1, 30, 6, 0)
		else:
			$Cam.start(0.1, 30, 2, 0)
		fire()
	else:
		$Muzzle/Fire.hide()
	
	if Input.is_action_just_pressed("switch_gun"):
		switch_gun()

func fire() -> void:
	var bullet = bullet_s.instance()
	get_parent().add_child(bullet)
	bullet.set_rot(rotation)
	bullet.global_position = $Muzzle.global_position
	bullet.apply_impulse(Vector2.ZERO, Vector2.RIGHT.rotated(rotation + randf()*spread - spread/2) * 800)
	Firetime.start()
	$Muzzle/Fire.show()
	Gunfire.pitch_scale = randf() / 2 + .75
	Gunfire.play()
	

func switch_gun() -> void:
	current_gun = (current_gun + 1) % guns.size()
	$Img.texture = guns[current_gun][0]
	Gunfire.stream = guns[current_gun][1]
	if current_gun == 0:
		Firetime.wait_time = .1
		spread = .1
		Gunfire.volume_db = -4
	else:
		Firetime.wait_time = .5
		spread = .3
		Gunfire.volume_db = 0


func _on_Detection_body_entered(body):
	if body.is_in_group("Enemies"):
		body.add_to_group(name)
	if !target:
		retarget()


func _on_Detection_body_exited(body):
	body.remove_from_group(name)
	retarget()

func retarget():
	var enemies := get_tree().get_nodes_in_group(name)
	if enemies.size() > 0:
		target = enemies[0]
	else:
		target = null
	
