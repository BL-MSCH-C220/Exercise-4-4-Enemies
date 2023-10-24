extends Node

@onready var SM = get_parent()
@onready var enemy = get_node("../..")

func _ready():
	await enemy.ready

func start():
	enemy.set_animation("Moving")

func physics_process(_delta):
	if enemy.should_attack():
		SM.set_state("Attack")
	if not enemy.is_on_floor():
		enemy.velocity.y += 50
	else: enemy.velocity.y = 0

	if not enemy.get_node("See").is_colliding():
		enemy.velocity.x = enemy.running*enemy.direction
	elif not enemy.get_node("Can_Jump").is_colliding():
		if enemy.is_on_floor():
			enemy.velocity.y -= enemy.jump
	elif enemy.is_on_floor():
		enemy.direction *= -1
	var t = enemy.get_node("See").get_collider()
	if t != null and t.name == "Player":
		enemy.velocity.x = 0

		
