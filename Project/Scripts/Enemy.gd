extends KinematicBody2D

enum { NONE, FRAG, TIME_EXTEND }

var holding_power_up: int
var velocity = Vector2()

func start(pos, speed, power_up = NONE):
	self.position = pos
	velocity = Vector2(speed, 0)
	holding_power_up = power_up
	if power_up == NONE:
		$BaseSprite.modulate = Color(1,1,1) 
	elif power_up == FRAG:
		$BaseSprite.modulate = Color(1, 0.46, 0.37)
	elif power_up == TIME_EXTEND:
		$BaseSprite.modulate = Color(1,1,0.47)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("explode"):
			collision.collider.explode()
			queue_free()
	pass

# Destroys this enemy when not in view/camera render
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# Called by the exploding bomb
func kill():
	if !GlobalPlayer.game_over:
		GlobalScore.curr_score += 1
		_trigger_power_up()
	queue_free()
	
func _trigger_power_up():
	if holding_power_up == FRAG:
		GlobalPlayer.activate_frag()
	elif holding_power_up == TIME_EXTEND:
		GlobalPlayer.timer_to_add += 5
	pass
