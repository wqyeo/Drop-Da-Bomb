extends Node


var speed:int = 200
var max_left:int = 145
var max_right:int = 1225

var moving_left:bool = true
var y_position: int

func _ready():
	y_position = self.position.y
	pass

func _process(delta):
	var position = self.position
	if moving_left:
		position = position.move_toward(Vector2(max_left, y_position), delta * speed)
	else:
		position = position.move_toward(Vector2(max_right, y_position), delta * speed)
	
	self.position = position
	
	if position.x <= max_left:
		moving_left = false
	elif position.x >= max_right:
		moving_left = true
	pass
