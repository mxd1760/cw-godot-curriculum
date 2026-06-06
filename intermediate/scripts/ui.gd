extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var idol_texture_rect: TextureRect = $IdolTextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = "0"
	idol_texture_rect.modulate = Color(0,0,0,1)
	Globals.idol_collected.connect(on_idol_collected)
	Globals.score_changed.connect(on_score_changed)
	pass # Replace with function body.

func on_score_changed(new_score):
	score_label.text = str(new_score)
	pass
	
func on_idol_collected():
	idol_texture_rect.modulate = Color(1,1,1,1)
	pass
