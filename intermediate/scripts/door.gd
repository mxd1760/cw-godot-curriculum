extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var is_door_open = false:
	set(v):
		is_door_open=v
		if is_door_open:
			sprite_2d.texture = preload("uid://chrmx0ju061aq")
			sprite_2d.position = Vector2(45,13)
		else:
			sprite_2d.texture = preload("uid://be7iolaircbsc")
			sprite_2d.position = Vector2(0,0)
			

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_door_open = false
	Globals.idol_collected.connect(open_door)
	pass # Replace with function body.

func open_door():
	is_door_open = true


func _on_body_entered(_body: Node2D) -> void:
	if is_door_open:
		Globals.call_deferred("go_to_next_level")
	else:
		print("get the key to open the door")
