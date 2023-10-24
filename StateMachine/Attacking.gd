extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.set_animation("Attacking",Vector2(5,7))
	$Timer.start()

func end():
	player.get_node("AnimatedSprite2D").offset.y = 0

func physics_process(_delta):
	pass


func _on_Timer_timeout():
	if SM.state_name == "Attacking":
		player.attack()
