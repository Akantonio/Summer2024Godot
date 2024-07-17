extends Node2D

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	# Functions to connect the player's health to the gui with 
	# that information
	#Sets our max amount of hearts for the gui to render
	heartsContainer.setMaxHearts(player.maxHealth)
	#Then we update with the players current hearts
	heartsContainer.updateHearts(player.currentHealth)
	#Here we connect the signal from the player saying we updated health
	player.healthChanged.connect(heartsContainer.updateHearts)
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
