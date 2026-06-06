extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.play("Jump")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		#animated_sprite_2d.flip_h = direction<0 # clever way to do the same thing as the following if
		if direction<0:
			animated_sprite_2d.flip_h=true
		else:
			animated_sprite_2d.flip_h=false

		if is_on_floor():
			animated_sprite_2d.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite_2d.play("Stand")

	move_and_slide()
