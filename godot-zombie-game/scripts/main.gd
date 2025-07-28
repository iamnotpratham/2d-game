extends Node2D

signal score_updated(score)
signal wave_updated(wave)

var zombie_scenes = [
	preload("res://scenes/zombie.tscn"),
	preload("res://scenes/fast_zombie.tscn"),
	preload("res://scenes/strong_zombie.tscn")
]
var powerup_scene = preload("res://scenes/powerup.tscn")
var tile_size = 16
var score = 0
var wave = 1
var zombies_in_wave = 10
var zombies_spawned = 0
var zombies_killed = 0

func _ready():
	generate_level()
	spawn_wave()

func spawn_wave():
	zombies_spawned = 0
	zombies_killed = 0
	for i in range(zombies_in_wave):
		spawn_zombie()

func spawn_zombie():
	var zombie_scene = zombie_scenes[randi() % zombie_scenes.size()]
	var zombie = zombie_scene.instantiate()
	zombie.position = Vector2(randi_range(0, 1152), randi_range(0, 648))
	add_child(zombie)
	zombies_spawned += 1

func generate_level():
	var tile_map = get_node("TileMap")
	var width = 1152 / tile_size
	var height = 648 / tile_size
	for x in range(width):
		for y in range(height):
			if x == 0 or x == width - 1 or y == 0 or y == height - 1:
				tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0))

func _on_zombie_killed():
	score += 10
	emit_signal("score_updated", score)
	zombies_killed += 1
	if zombies_killed == zombies_in_wave:
		wave += 1
		emit_signal("wave_updated", wave)
		zombies_in_wave += 5
		spawn_wave()
	if randf() < 0.1:
		spawn_powerup()

func spawn_powerup():
	var powerup = powerup_scene.instantiate()
	powerup.position = Vector2(randi_range(0, 1152), randi_range(0, 648))
	add_child(powerup)

func game_over():
	var game_over_scene = load("res://scenes/game_over.tscn").instantiate()
	game_over_scene.set_score(score)
	get_tree().get_root().add_child(game_over_scene)
	queue_free()
