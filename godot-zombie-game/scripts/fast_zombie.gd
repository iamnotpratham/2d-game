extends "res://scripts/zombie.gd"

func _ready():
	SPEED = 250.0
	health = 2
	player = get_node("/root/Main/Player")
