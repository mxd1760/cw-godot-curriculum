extends Node3D

class_name BaseGun


var ammo:int:
	get = get_ammo , set = set_ammo
func set_ammo(v):
	ammo = v
func get_ammo():
	return ammo

@export var weapon_profile:WeaponProfile
@export var fire_delay = 1
@export var reload_delay = 3
@export var magazine_size = 10


var can_shoot = true:
	set(v):
		can_shoot = v
		if not can_shoot:
			await get_tree().create_timer(fire_delay).timeout
			can_shoot=true
func shoot():
	if ammo<=0:
		if not reloading:
			reload()
			return
	elif can_shoot:
		if weapon_profile:
			weapon_profile.fire(self,-global_basis.z)
		can_shoot=false
		ammo-=1
	pass

var reloading = false
func reload():
	print("reloading")
	reloading=true
	await get_tree().create_timer(reload_delay).timeout
	reloading=false
	ammo=magazine_size
	
func swap_next_ammo_type():
	if weapon_profile:
		var dt = weapon_profile.damage_type
		weapon_profile.damage_type = ((dt+1)%WeaponProfile.DamageType.size()) as WeaponProfile.DamageType

func swap_prev_ammo_type():
	if weapon_profile:
		var dt = weapon_profile.damage_type
		weapon_profile.damage_type = (dt-1)%WeaponProfile.DamageType.size() as WeaponProfile.DamageType
