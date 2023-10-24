extends Node

@onready var SM = get_parent()
@onready var enemy = get_node("../..")

func _ready():
	await enemy.ready

func start():
	enemy.velocity = Vector2.ZERO
	enemy.set_animation("Dying")
	enemy.collision_layer = 0
	enemy.collision_mask = 0
