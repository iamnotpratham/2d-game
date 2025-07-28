extends CanvasLayer

func _ready():
	get_node("/root/Main").connect("score_updated", self, "_on_score_updated")
	get_node("/root/Main").connect("wave_updated", self, "_on_wave_updated")

func _on_score_updated(score):
	$ScoreLabel.text = "Score: " + str(score)

func _on_wave_updated(wave):
	$WaveLabel.text = "Wave: " + str(wave)
