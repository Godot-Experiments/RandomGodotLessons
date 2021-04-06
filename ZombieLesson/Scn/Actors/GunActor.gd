extends Moveable

export (PackedScene) var bullet_s = preload("res://Scn/Bullet.tscn")

var guns := {
	0 : [preload("res://Img/PNG/Soldier 1/soldier1_machine.png"), preload("res://Sfx/M4A1_Single-Kibblesbob-8540445.wav")], 
	1 : [preload("res://Img/PNG/Soldier 1/soldier1_gun.png"), preload("res://Sfx/Shotgun_Blast-Jim_Rogers-1914772763.wav")]
	}

# Gun parameters
var current_gun := 0
var spread := .1

# For AI, TODO: improve wander behavior
var rand_speed := randf() / 2 + .5

# For convenience
onready var Firetime := $Firetime
onready var Gunfire := $Muzzle/Gunfire
onready var Cam := $Cam
onready var Anim := $Tween


func _ready() -> void:
	group_up_location = get_parent().get_node("GroupUp")
	if player_controlled:
		Cam.current = true

# This function runs every 1/60th of a second, why didn't I modularize? Performance (don't wanna make bunch of function calls), eventually wanna transition into DOTS like system
func _physics_process(delta: float) -> void:
	$Muzzle/Fire.hide()
	if player_controlled:
		
		# Get player input
		var vel = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
			).normalized()
		# If moving or firing, turn off slow-mo
		if vel.length_squared() != 0 or Input.is_action_pressed("fire"):
			Engine.time_scale = 1
			Anim.interpolate_property(Cam, "zoom", Cam.zoom, Vector2(1,1), .2)
			Anim.start()
		else:
			Engine.time_scale = .25
			Anim.interpolate_property(Cam, "zoom", Cam.zoom, Vector2(.9,.9), .2)
			Anim.start()
		
		# Move, look at mouse
		position += (Input.get_action_strength("sprint") + 1)* speed * delta * vel
		rotation += clamp(get_local_mouse_position().angle(), -TURN, TURN) * 10 * delta

		# Firing
		if Input.is_action_pressed("fire") and Firetime.is_stopped():
			fire()
		# Switching weapons
		elif Input.is_action_just_pressed("switch_gun"):
			switch_gun()
	
	# AI CONTROL BELOW HERE ------------------------------------------------------
	
	# if has a target, rotate towards it and fire
	elif target: 
		rotation += clamp(to_local(target.global_position).angle() * 10, -TURN, TURN) * delta
		if Firetime.is_stopped():
			fire()
	# if too far from waypoint, rotate towards waypoint
	elif global_position.distance_squared_to(group_up_location.global_position) > 50000:
		rotation += clamp(to_local(group_up_location.global_position).angle() * 10, -TURN, TURN) * delta
		position += walk_speed * delta * Vector2.RIGHT.rotated(rotation)
	# else walk forward
	else:
		position += rand_speed * walk_speed * delta * Vector2.RIGHT.rotated(rotation)


var group_up_location

# Fires based off the current_gun
func fire() -> void:
	if current_gun == 1:
		# fire_shotgun()
		for i in range(8):
			fire_single()
		Cam.start(0.1, 30, 6, 0)
	else:
		fire_single()
		Cam.start(0.1, 30, 2, 0)

# Fire a single bullet
func fire_single() -> void:
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


func _on_Detection_body_entered(body) -> void:
	if body.is_in_group(Global.ENEMIES):
		body.add_to_group(name)
	if !target:
		retarget()

func _on_Detection_body_exited(body) -> void:
	if body.is_in_group(name):
		body.remove_from_group(name)
		retarget()

func retarget() -> void:
	var enemies := get_tree().get_nodes_in_group(name)
	if enemies.size() > 0:
		target = enemies[0]
		if player_controlled:
			get_parent().Question.text = Qdb.qa[target.Value.text] # TODO: Fix hardcoding
	else:
		get_parent().Question.text = ""
		target = null

	
