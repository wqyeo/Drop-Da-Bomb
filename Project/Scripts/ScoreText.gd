extends Node

var prev_score = 0

func _process(delta):
	if prev_score != GlobalScore.curr_score:
		$ScoreLabel.text = "SCORE: " + str(GlobalScore.curr_score)
		$ScoreAnimPlayer.play("Pop")
		prev_score = GlobalScore.curr_score
