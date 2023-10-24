extends Node

@onready var SM = get_parent()
@onready var enemy = get_node("../..")

func _ready():
	await enemy.ready

func start():
	enemy.set_animation("Idle")

func physics_process(_delta):
	if enemy.should_attack():
		SM.set_state("Attack")
	else:
		enemy.velocity.x = enemy.direction * enemy.walking
		if enemy.position.x > enemy.path[1].x:
			enemy.velocity.x = -1*abs(enemy.walking)
		if enemy.position.x < enemy.path[0].x:
			enemy.velocity.x = abs(enemy.velocity.x)
