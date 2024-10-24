extends CharacterBody2D

const SPEED = 80
const JUMP_VELOCITY = -230
var JUMP_COUNT = 0
var FRUIT_POWER = 1
var LANDING : bool

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	# Handle jump and double jump
	# Can double jump if player falls off an edge
	# 2nd jump is 85% power to get up 3 vertical blocks
	if Input.is_action_just_pressed("jump") and JUMP_COUNT == 1:
		velocity.y = JUMP_VELOCITY * .85
		JUMP_COUNT = 2
		animation_player.play("jump_sound")
	if Input.is_action_just_pressed("jump") and JUMP_COUNT == 0:
		velocity.y = JUMP_VELOCITY
		JUMP_COUNT = 1
		animation_player.play("jump_sound")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		JUMP_COUNT = 1
		animation_player.play("jump_sound")
	if !Input.is_action_just_pressed("jump") and is_on_floor():
		JUMP_COUNT = 0
#Landing Sound
	if is_on_floor():
		if LANDING:
			animation_player.play("tap_sound")
			LANDING = false
	else:
		if !LANDING:
			LANDING = true
		




	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction := Input.get_axis("left", "right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	#Play Animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	move_and_slide()
