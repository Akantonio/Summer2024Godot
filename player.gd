extends CharacterBody2D

signal healthChanged

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var maxHealth = 5
@onready var currentHealth: int = maxHealth

func _process(_delta):
	if Input.is_action_just_pressed("keyboard_attack"):
		$Area2D/CollisionShape2D.disabled = false
		#TODO: add animation for attacking
	else:
		$Area2D/CollisionShape2D.disabled = true

func _physics_process(delta):
	#animations
	if (velocity.x > 1 || velocity.x < -1):
		$Sprite2D.animation = "run"
	else:
		$Sprite2D.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$Sprite2D.animation = "jump"

	# Handle jump.
	if Input.is_action_just_pressed("keyboard_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("keyboard_left", "keyboard_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	var isLeft = velocity.x < 0
	$Sprite2D.flip_h = isLeft

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
