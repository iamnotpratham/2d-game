extends Control

func _ready():
	$CenterContainer/VBoxContainer/RestartButton.connect("pressed", self, "_on_RestartButton_pressed")
	$CenterContainer/VBoxContainer/MainMenuButton.connect("pressed", self, "_on_MainMenuButton_pressed")

func set_score(score):
	$CenterContainer/VBoxContainer/ScoreLabel.text = "Score: " + str(score)

func _on_RestartButton_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_MainMenuButton_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
