extends "res://scripts/zombie.gd"

func _ready():
	SPEED = 100.0
	health = 5
	player = get_node("/root/Main/Player")
