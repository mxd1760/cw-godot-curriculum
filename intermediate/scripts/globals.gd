extends Node

signal idol_collected
signal score_changed

var score = 0:
	set(v):
		score_changed.emit(v)
		score = v

func emit_idol_collected():
	idol_collected.emit()

var level_index = 0
var level_list = [
	"res://levels/level_1.tscn",
	"res://levels/level_2.tscn"
	
]

func go_to_next_level():
	level_index += 1
	level_index %= len(level_list) # don't let the index be outside the list (last level will have the first level as its next level)
	get_tree().change_scene_to_file(level_list[level_index])
