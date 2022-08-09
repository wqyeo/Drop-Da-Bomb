extends KinematicBody2D


var velocity = Vector2()

func start(pos, speed):
	self.position = pos
	velocity = Vector2(0, speed)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("kill"):
			collision.collider.kill()
			queue_free()
	pass

# Destroys this bomb when not in view/camera render
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func explode():
	# TODO: Handle explosion
	queue_free()
