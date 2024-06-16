<<<<<<< HEAD
#enemy.gd
extends CharacterBody2D

#node reference
@onready var navigation_agent = $NavigationAgent2D
@export var target_to_chase: CharacterBody2D

#signal name(param,param)
signal on_hit_signal

#default speed was 300
const SPEED = 180.0

func _ready():
	set_physics_process(false)
	call_deferred("wait_for_physics")

# confirms that physics happened in 1 frame
func wait_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)
	

func _physics_process(_delta):
	if navigation_agent.is_navigation_finished() and\
						 target_to_chase.global_position == navigation_agent.target_position:
		on_hit_signal.emit()
		return
	navigation_agent.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * SPEED
=======
extends CharacterBody2D

@onready var navigation_region = $NavigationRegion2D

const SPEED = 300.0


func _physics_process(delta):

>>>>>>> e45f5c3 (Added script for enemy scene)
	move_and_slide()
