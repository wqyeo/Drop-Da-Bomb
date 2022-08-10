extends KinematicBody2D


var velocity = Vector2()

func start(pos, speed):
	self.position = pos
	velocity = Vector2(speed, 0)

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
	Global.curr_score += 1
	queue_free()
