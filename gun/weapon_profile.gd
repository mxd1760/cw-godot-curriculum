@abstract
extends Resource


class_name WeaponProfile
enum DamageType {Red,Green,Blue}

@export var damage_type = DamageType.Red
func fire(_source:Node3D,_direction:Vector3):
	pass
