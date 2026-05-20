extends Node3D

class_name BaseGun


var ammo:int=10:
	get = get_ammo , set = set_ammo
func set_ammo(v):
	ammo = v
	if ammo_counter:
		ammo_counter.text = str(ammo)+"/"+str(magazine_size)
func get_ammo():
	return ammo

@export var weapon_profile:WeaponProfile
@export var fire_delay:float = 1
@export var reload_delay:float = 3
@export var magazine_size:int = 10
@export var base_damage:int = 10
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var ammo_counter = null

var reloading = false
var can_shoot = true:
	set(v):
		can_shoot = v
		if not can_shoot:
			animation_player.speed_scale = 1/fire_delay
			animation_player.play("recoil")
			await animation_player.animation_finished
			can_shoot=true

func _ready():
	ammo = magazine_size
func shoot():
	if ammo<=0:
		if not reloading:
			reload()
			return
	elif can_shoot:
		if weapon_profile:
			weapon_profile.base_damage = base_damage
			weapon_profile.fire(self,-global_basis.z)
		can_shoot=false
		ammo-=1
	pass


func reload():
	reloading=true
	animation_player.speed_scale = 1/reload_delay
	animation_player.play("reload")
	await animation_player.animation_finished
	reloading=false
	ammo=magazine_size
	
