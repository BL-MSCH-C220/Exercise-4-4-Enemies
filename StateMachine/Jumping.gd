extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.set_animation("Jumping")
	player.jump_power = Vector2.ZERO

func physics_process(_delta):
	if not player.is_on_floor():
		player.velocity += player.move_speed * player.move_vector() + player.gravity
		player.move_and_slide()
	if player.is_moving():
		player.jump_power.x = clamp(player.jump_power.x + (player.move_vector().x * player.leap_speed), -player.max_leap, player.max_leap)
	if Input.is_action_pressed("jump"):
		player.jump_power.y = clamp(player.jump_power.y - player.jump_speed, -player.max_jump, 0)
	else:
		player.velocity.y = 0
		player.velocity += player.jump_power
		player.move_and_slide()
		SM.set_state("Falling")

