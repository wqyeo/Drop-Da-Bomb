extends Control

var transitioning = false

func _ready():
	MusicController.play_BGM()
	
	var high_score = GlobalScore.read_high_score()
	if high_score == 0:
		$HighScoreLabel.text = "NO HIGH SCORE SET"
	else:
		$HighScoreLabel.text = "HIGH SCORE: " + str(high_score)

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE) and !transitioning:
		transitioning = true
		$StartText/AnimationPlayer.play("BlinkTransition")
		MusicController.play_UISelect()
		
func to_game_scene():
	get_tree().change_scene("res://Scenes/GameScene.tscn")
