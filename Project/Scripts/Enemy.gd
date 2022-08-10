extends KinematicBody2D

enum { NONE, FRAG, TIME_EXTEND }

var frag_icon = preload("res://Sprites/FragIcon.png")
var time_extend_icon = preload("res://Sprites/TimeExtendIcon.png")

var holding_power_up: int
var velocity = Vector2()

func start(pos, speed, power_up = NONE):
	self.position = pos
	velocity = Vector2(speed, 0)
	holding_power_up = power_up
	if power_up == NONE:
		$PowerUpIcon.visible = false
		$BaseSprite.modulate = Color(1,1,1) 
	elif power_up == FRAG:
		$PowerUpIcon.texture = frag_icon
	elif power_up == TIME_EXTEND:
		$PowerUpIcon.texture = time_extend_icon

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
	GlobalScore.curr_score += 1
	_trigger_power_up()
	queue_free()
	
func _trigger_power_up():
	if holding_power_up == FRAG:
		GlobalPlayer.activate_frag()
	pass
