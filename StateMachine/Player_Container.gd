extends Node2D

@onready var Player = load("res://Player/Player.tscn")
var starting_position = Vector2(200,200)


func _physics_process(_delta):
	if not has_node("Player"):
		var player = Player.instantiate()
		player.position = starting_position
		add_child(player)
