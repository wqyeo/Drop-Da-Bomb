extends Position2D

export (int) var max_Y = 750
export (int) var min_Y = 210

export (int) var max_speed = 200
export (int) var min_speed = 1000

export (float) var min_spawn_timer:float = 1
export (float) var max_spawn_timer:float = 3

export (int) var max_enemy_speed = 100
export (int) var min_enemy_speed = 600

export (bool) var is_left_spawner = true

var enemy_scene = preload("res://Scenes/EnemyScene.tscn")

var curr_spawn_timer:float = 1
var spawn_timer:float = 0

var curr_speed:int = 400
var moving_down:bool = true
var x_position:int

var random = RandomNumberGenerator.new()

func _ready():
	x_position = self.position.x
	pass

func _process(delta):
	_process_movement(delta)
	
	spawn_timer += delta
	# Spawn timer
	if spawn_timer >= curr_spawn_timer:
		_spawn_enemy()
		curr_spawn_timer = rand_range(min_spawn_timer, max_spawn_timer)
		spawn_timer = 0
		random.randomize()
		curr_speed = random.randi_range(min_speed, max_speed)
	pass
	
func _process_movement(delta):
	var position = self.position
	if moving_down:
		position = position.move_toward(Vector2(x_position, max_Y), delta * curr_speed)
	else:
		position = position.move_toward(Vector2(x_position, min_Y), delta * curr_speed)
	self.position = position
	
	# Flip spawner move direction once border is hit.
	if max_Y <= position.y:
		moving_down = false
	elif min_Y >= position.y:
		moving_down = true
	
func _spawn_enemy():
	var enemy = enemy_scene.instance()
	random.randomize()
	var enemy_speed = random.randi_range(min_enemy_speed, max_enemy_speed)
	# Make the enemy move in the correct direction based on where the spawner is.
	if is_left_spawner:
		enemy.start(self.global_position, enemy_speed)
	else:
		enemy.start(self.global_position, -enemy_speed)
	get_parent().add_child(enemy)
