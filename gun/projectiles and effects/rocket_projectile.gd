extends Area3D

@export var speed:int = 30
@export var explosion: PackedScene
@onready var forward = -basis.z
var base_damage = 10

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("deal_damage"):
		body.deal_damage(base_damage*2)
	explode()
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position += forward*speed*delta

func explode():
	if explosion:
		var new_explosion = explosion.instantiate()
		new_explosion.position = self.position
		new_explosion.base_damage = base_damage
		get_tree().root.add_child(new_explosion)
	queue_free()
	
