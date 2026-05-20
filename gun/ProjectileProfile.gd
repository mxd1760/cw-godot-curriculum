extends WeaponProfile

class_name ProjectileProfile
@export var projectile_scene:PackedScene 

func fire(source:Node3D,direction:Vector3):
	var projectile:Node3D = projectile_scene.instantiate()
	projectile.look_at_from_position(Vector3(0,0,0),direction)
	projectile.position = source.global_position
	source.get_tree().root.add_child(projectile)
	projectile.forward = direction
	
