extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
#@onready var kryptonite: Sprite2D = $Kryptonite
#@onready var bullet: Sprite2D = $Bullet
@onready var bullet_list: Node2D = $bullet_list
@onready var kryptonite_list: Node2D = $kryptonite_list
const KRYPTONITE = preload("uid://cx1b0ucmec15x")
const BULLET = preload("uid://8cjwf3728jcy")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_pressed("ui_up"):
		sprite_2d.position.y-=10
	if Input.is_action_pressed("ui_down"):
		sprite_2d.position.y+=10

	var size_y = get_viewport_rect().size.y
	var pos_y = get_viewport_rect().position.y
	if sprite_2d.position.y>size_y+pos_y:
		sprite_2d.position.y=size_y+pos_y
	if sprite_2d.position.y<pos_y:
		sprite_2d.position.y=pos_y
	
	#if kryptonite:
	for kryptonite in kryptonite_list.get_children():
		kryptonite.position.x-=10
	
	#if bullet:
	for bullet in bullet_list.get_children():
		bullet.position.x+=10
		
	if Input.is_action_just_pressed("ui_accept"):
		spawn_bullet()

func _on_timer_timeout() -> void:
	spawn_enemy()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_bullet_hits_kryptonite(area: Area2D) -> void:
	area.get_parent().queue_free()
	pass # Replace with function body.
	

func spawn_bullet():
	# make a copy
	var bullet_copy = BULLET.instantiate()
	# adjust settings
	bullet_copy.position = sprite_2d.position
	bullet_copy.get_node("Area2D").area_entered.connect(_on_bullet_hits_kryptonite)
	# add to scene
	bullet_list.add_child(bullet_copy)

func spawn_enemy():
	# make a copy
	var kryptonite_copy = KRYPTONITE.instantiate()
	# adjust settings
	var size_x = get_viewport_rect().size.x
	var pos_x = get_viewport_rect().position.x
	var size_y = get_viewport_rect().size.y
	var pos_y = get_viewport_rect().position.y
	kryptonite_copy.position.x = size_x+pos_x+200
	kryptonite_copy.position.y = pos_y + (randf()*size_y)
	kryptonite_copy.get_node("Area2D").area_entered.connect(_on_area_2d_area_entered)
	# add to scene
	kryptonite_list.add_child(kryptonite_copy)
