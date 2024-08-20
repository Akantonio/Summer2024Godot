extends CharacterBody2D

signal healthChanged

const NORMALSPEED = 350.0
const JUMP_VELOCITY = -550.0

const dashspeed = 3000
const dashlength = .1

@onready var dash = $Dash



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var maxHealth = 5
@onready var currentHealth: int = maxHealth
@onready var isLeft = false

func _process(_delta):
	if Input.is_action_just_pressed("keyboard_attack"):
		$Area2D/CollisionShape2D.disabled = false
		#TODO: add animation for attacking
	else:
		$Area2D/CollisionShape2D.disabled = true

func _physics_process(delta):	
	if Input.is_action_just_pressed("keyboard_dash"):
		dash.start_dash(dashlength)
		#TODO add dash animation
	
	var speed
	#Change speed if we are dashing
	if dash.is_dashing():
		speed = dashspeed
	else:
		speed = NORMALSPEED
	
		#Run and idle animations
	if (velocity.x > 1 || velocity.x < -1):
		#if not $Sprite2D.animation == "run" :
			#$Sprite2D.animation = "run"
			#$Sprite2D.animation.play()
			$Sprite2D.play("run")
	else:
		#if not $Sprite2D.animation == "idle" :
			#$Sprite2D.animation = "idle"
			$Sprite2D.play("idle")

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y < 0:
			$Sprite2D.animation = "jump"
		else:
			$Sprite2D.animation = "fall"
			

	# Handle jump.
	if Input.is_action_just_pressed("keyboard_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("keyboard_left", "keyboard_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	#check if the player has moved in a direction and update it accordingly
	
	if velocity.x != 0:
		isLeft = velocity.x < 0

	$Sprite2D.flip_h = isLeft
	move_and_slide()

func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		currentHealth -= 1
		if currentHealth == 0:
			currentHealth = maxHealth
		
		healthChanged.emit(currentHealth)
		print_debug(currentHealth); 

func _on_area_2d_body_entered(body):
	if body.is_in_group("Hit"):
		body.take_damage()
	else:
		pass
