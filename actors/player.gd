extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENS_X = 0.01
const SENS_Y = 0.01
@onready var camera_3d: Camera3D = $Camera3D


@onready var ammo_counter: Label = $CanvasLayer/AmmoCounter		
@onready var weapon_attatch_point: Node3D = $Camera3D/WeaponAttatchPoint

@export var weapon_list: Array[PackedScene]
var weapon_idx = 0:
	set(v):
		if weapon_idx != v:
			weapon_idx = v
			setup_weapon()

func setup_weapon():
	if weapon_attatch_point.get_child_count()!=0:
		weapon_attatch_point.get_child(0).queue_free()
	var weapon = weapon_list[weapon_idx].instantiate()
	weapon.ammo_counter = ammo_counter
	weapon_attatch_point.add_child(weapon)
			

func _ready():
	toggle_mouse_capture()
	setup_weapon()
	var bad_weapons=[]
	for w in weapon_list:
		var instance = w.instantiate()
		if not (instance is BaseGun):
			bad_weapons.push_back(w)
	for w in bad_weapons:
		weapon_list.erase(w)
		
func toggle_mouse_capture():
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			rotate(Vector3.UP,-event.relative.x*SENS_X)
			camera_3d.rotate(Vector3.RIGHT,-event.relative.y*SENS_Y)
			camera_3d.rotation.x = clampf(camera_3d.rotation.x,deg_to_rad(-80),deg_to_rad(80))

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_mouse_capture()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("swap_next_gun"):
		weapon_idx= (weapon_idx+1)%weapon_list.size()
	if Input.is_action_just_pressed("swap_prev_gun"):
		weapon_idx= (weapon_idx-1)%weapon_list.size()
	if Input.is_action_just_pressed("pick_gun_1"):
		if weapon_list.size()>=1:
			weapon_idx = 0 #1-1
	if Input.is_action_just_pressed("pick_gun_2"):
		if weapon_list.size()>=2:
			weapon_idx = 1 #2-1
	if Input.is_action_just_pressed("pick_gun_3"):
		if weapon_list.size()>=3:
			weapon_idx = 2 #3-1
	if Input.is_action_pressed("shoot"):
		weapon_attatch_point.get_child(0).shoot()
