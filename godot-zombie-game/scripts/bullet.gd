extends Area2D

const SPEED = 1000.0
var velocity = Vector2.ZERO
var damage = 1

func _ready():
	velocity = Vector2.from_angle(rotation) * SPEED
	connect("body_entered", Callable(self, "_on_Bullet_body_entered"))

func _physics_process(delta):
	position += velocity * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("zombies"):
		body.take_damage(damage)
	queue_free()

func _on_VisibleOnScreenNotifier2D_screen_exited():
	queue_free()
