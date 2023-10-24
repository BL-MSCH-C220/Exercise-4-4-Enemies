extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Coyote")
	else:
		player.velocity.y = 0

	player.jump_power.y = clamp(player.jump_power.y - player.jump_speed, -player.max_jump, 0)
	if Input.is_action_just_released("jump"):
		player.velocity.y = 0
		player.velocity += player.jump_power
		player.move_and_slide()
		SM.set_state("Falling")
	elif player.is_moving():
		player.set_animation("Moving")
		player.velocity += player.move_speed * player.move_vector()
		player.move_and_slide()
	else:
		player.velocity.x = 0
		SM.set_state("Jumping")
