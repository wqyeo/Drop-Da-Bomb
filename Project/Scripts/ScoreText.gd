extends Node

var prev_score = 0

func _ready():
	GlobalScore.trigger_new_game()

func _process(delta):
	if prev_score != GlobalScore.curr_score:
		$ScoreLabel.text = "SCORE: " + str(GlobalScore.curr_score)
		$ScoreAnimPlayer.play("Pop")
		prev_score = GlobalScore.curr_score
