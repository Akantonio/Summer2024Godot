extends CharacterBody2D

@onready var navigation_region = $NavigationRegion2D

const SPEED = 300.0


func _physics_process(delta):

	move_and_slide()
