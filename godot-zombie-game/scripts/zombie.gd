extends CharacterBody2D

const SPEED = 150.0
var player = null
var health = 3
var death_sound = preload("res://assets/zombie_death.wav")

func _ready():
	player = get_node("/root/Main/Player")

func _physics_process(delta):
	var direction = (player.position - position).normalized()
	velocity = direction * SPEED
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("player"):
			collision.get_collider().take_damage(1)

func take_damage(damage):
	health -= damage
	if health <= 0:
		get_node("/root/Main")._on_zombie_killed()
		var audio_player = AudioStreamPlayer.new()
		audio_player.stream = death_sound
		get_parent().add_child(audio_player)
		audio_player.play()
		queue_free()
