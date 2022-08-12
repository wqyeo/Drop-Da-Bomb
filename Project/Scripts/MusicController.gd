extends Node


var bgm = load("res://Sounds/BGM.mp3")
var explosion = load("res://Sounds/Explosion.wav")
var UISelect = load("res://Sounds/UISelect.wav")

func _ready():
	$Music.stream = bgm
	$Explosion.stream = explosion
	$UISelect.stream = UISelect

func play_BGM():
	$Music.play()

func play_Explosion():
	$Explosion.play()

func play_UISelect():
	$UISelect.play()
