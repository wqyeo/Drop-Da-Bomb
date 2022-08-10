extends Node

var prev_score = 0

func _process(delta):
	if prev_score != Global.curr_score:
		$ScoreLabel.text = "SCORE: " + str(Global.curr_score)
		$ScoreAnimPlayer.play("Pop")
		prev_score = Global.curr_score
