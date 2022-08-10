extends Node

export (int) var speed:int = 200
export (int) var max_left:int = 145
export (int) var max_right:int = 1225
export (int) var bomb_speed: int = 400
export (int) var reload_duration :float = 2

signal bomb_ready
signal bomb_hold
signal bomb_launched

var bomb_scene = preload("res://Scenes/BombScene.tscn")

var moving_left:bool = true
var y_position: int
var reload_timer :float = 1

func _ready():
	y_position = self.position.y
	pass

func _process(delta):
	if reload_timer <= reload_duration:
		_wait_for_reload(delta)
	else:
		_process_bombing_inputs(delta)
	pass

func _wait_for_reload(delta):
	reload_timer += delta
	_process_hover(delta)
	if reload_timer >= reload_duration:
		emit_signal("bomb_ready")
	
func _process_bombing_inputs(delta):
	# Button was let go, drop bomb
	if Input.is_action_just_released("drop_bomb"):
		emit_signal("bomb_launched")
		$BombSpawn/LaserSight.visible = false
		_drop_bomb()
	# Button is held down, aim
	elif Input.is_action_pressed("drop_bomb"):
		$BombSpawn/LaserSight.visible = true
		emit_signal("bomb_hold")
	else:
		_process_hover(delta)

func _process_hover(delta):
	# Move left/right based on the current toggle
	var position = self.position
	if moving_left:
		position = position.move_toward(Vector2(max_left, y_position), delta * speed)
	else:
		position = position.move_toward(Vector2(max_right, y_position), delta * speed)
	
	self.position = position
	
	# Toggle move direction if hit the move limit
	if position.x <= max_left:
		moving_left = false
	elif position.x >= max_right:
		moving_left = true 
	pass
	
func _drop_bomb():
	var bomb = bomb_scene.instance()
	bomb.start($BombSpawn.global_position, bomb_speed, GlobalPlayer.frag_active)
	get_parent().add_child(bomb)
	reload_timer = 0
	pass
