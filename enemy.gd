extends CharacterBody2D


@onready var navigation_agent = $NavigationAgent2D
@export var target_to_chase: CharacterBody2D

#default speed was 300
const SPEED = 180.0

func _ready():
	set_physics_process(false)
	call_deferred("wait_for_physics")

# confirms that physics happened in 1 frame
func wait_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)
	

func _physics_process(delta):
	navigation_agent.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * SPEED
	move_and_slide()
