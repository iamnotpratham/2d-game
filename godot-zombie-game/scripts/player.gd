extends CharacterBody2D

var SPEED = 300.0
var bullet_scene = preload("res://scenes/bullet.tscn")
var health = 10
var bullet_damage = 1
var shoot_sound = preload("res://assets/shoot.wav")

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()

	look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.rotation = rotation
	bullet.position = position
	bullet.damage = bullet_damage
	get_parent().add_child(bullet)
	$AudioStreamPlayer.stream = shoot_sound
	$AudioStreamPlayer.play()

func take_damage(damage):
	health -= damage
	if health <= 0:
		get_node("/root/Main").game_over()
