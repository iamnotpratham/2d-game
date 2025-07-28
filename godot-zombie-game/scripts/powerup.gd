extends Area2D

enum PowerUpType { SPEED_BOOST, DAMAGE_BOOST }

var type = PowerUpType.SPEED_BOOST

func _ready():
	connect("body_entered", Callable(self,"_on_PowerUp_body_entered"))

func _on_PowerUp_body_entered(body):
	if body.is_in_group("player"):
		apply_powerup(body)
		queue_free()

func apply_powerup(player):
	match type:
		PowerUpType.SPEED_BOOST:
			player.SPEED *= 1.5
			yield(get_tree().create_timer(5.0), "timeout")
			player.SPEED /= 1.5
		PowerUpType.DAMAGE_BOOST:
			player.bullet_damage *= 2
			yield(get_tree().create_timer(5.0), "timeout")
			player.bullet_damage /= 2
