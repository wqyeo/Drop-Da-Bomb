extends Control

var enabled = false

func _process(delta):
	if !enabled:
		return
		
	if Input.is_key_pressed(KEY_SPACE):
		MusicController.play_UISelect()
		$AnimationPlayer.play("BlinkTransition")
		enabled = false

func enable():
	raise()
	enabled = true
	
func move_to_main_menu():
	get_tree().change_scene("res://Scenes/Menu.tscn")

func _on_TimerText_time_up():
	_set_score_texts()
	$AnimationPlayer.play("ShowGameOverMenu")

func _set_score_texts():
	var curr_score = GlobalScore.curr_score
	var high_score = GlobalScore.read_high_score()
	
	if curr_score > high_score:
		$ScoreLabel.text = "NEW HIGH SCORE: " + str(curr_score)
		GlobalScore.save_high_score(curr_score)
	else:
		$ScoreLabel.text = "YOUR SCORE: " + str(curr_score) + "\nHIGH SCORE: " + str(high_score)
