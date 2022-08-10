extends Node2D

enum { BOMB_READY, BOMB_AIM, BOMB_LAUNCHED }

var state = BOMB_READY

func _on_Player_bomb_hold():
	if state == BOMB_READY:
		$BombStateLabel.text = "AIMING"
		$BombStatePlayer.stop()
		$BombStatePlayer.play("BlinkAnim")
		state = BOMB_AIM
	pass


func _on_Player_bomb_launched():
	if state == BOMB_AIM:
		$BombStateLabel.text = "LAUNCHED"
		$BombStatePlayer.stop()
		$BombStatePlayer.play("BlinkAnim")
		state = BOMB_LAUNCHED
	pass


func _on_Player_bomb_ready():
	if state == BOMB_LAUNCHED:
		$BombStateLabel.text = "READY"
		$BombStatePlayer.stop()
		$BombStatePlayer.play("BlinkAnim")
		state = BOMB_READY
	pass
