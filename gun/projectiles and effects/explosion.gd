extends Area3D


@export var LIFETIME = 1
var damage_type = WeaponProfile.DamageType.Red

func _ready():
	await get_tree().create_timer(LIFETIME).timeout
	queue_free()

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("deal_damage"):
		body.deal_damage()
	pass # Replace with function body.
