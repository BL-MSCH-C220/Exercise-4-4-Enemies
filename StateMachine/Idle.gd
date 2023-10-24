extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.velocity = Vector2(0,1.0)
	player.set_animation("Idle")

func physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	if player.is_moving():
		SM.set_state("Moving")
	if Input.is_action_pressed("jump"):
		SM.set_state("Jumping")
