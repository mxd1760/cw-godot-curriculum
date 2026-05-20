extends Area3D


@export var LIFETIME = 0.2

func _ready():
	monitoring = false
	await get_tree().create_timer(0.01).timeout
	monitoring = true
	await get_tree().create_timer(LIFETIME).timeout
	queue_free()

func _on_body_entered(body: Node3D) -> void:
	print("explosion")
	print(body.name)
	if body.has_method("deal_damage"):
		body.deal_damage(100)
	pass # Replace with function body.
