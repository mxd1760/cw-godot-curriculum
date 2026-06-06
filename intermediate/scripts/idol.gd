extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	Globals.emit_idol_collected()
	queue_free()
	pass # Replace with function body.
