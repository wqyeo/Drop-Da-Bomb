extends KinematicBody2D


var velocity = Vector2()

func start(pos, speed):
	self.position = pos
	velocity = Vector2(0, speed)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		# TODO: Handle collisions
		print("Collided with ", collision.collider.name)
	pass

# Destroys this bomb when not in view/camera render
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
