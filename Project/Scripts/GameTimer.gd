extends Node

var curr_time:float = 60

signal time_up

func _process(delta):
	if GlobalPlayer.game_over:
		return
	
	if GlobalPlayer.timer_to_add > 0:
		_add_time(GlobalPlayer.timer_to_add)
		GlobalPlayer.timer_to_add = 0
	curr_time -= delta
	_update_timer()
	
	if curr_time <= 0:
		GlobalPlayer.game_over = true
		emit_signal("time_up")

func _update_timer():
	var mins = str(int(curr_time / 60))
	var seconds = str(int(curr_time) % 60)
	
	if seconds.length() == 1:
		seconds = "0" + seconds
	
	$TimerLabel.text = mins + ":" + seconds
	
func _add_time(seconds):
	curr_time += seconds
	$TimerAnimPlayer.play("Pop")
