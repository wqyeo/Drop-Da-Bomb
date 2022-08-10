extends KinematicBody2D


var velocity = Vector2()
var explosionParticle = preload("res://Scenes/BombExplodeParticle.tscn")

func start(pos, speed):
	self.position = pos
	velocity = Vector2(0, speed)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("kill"):
			explode()
	pass

# Destroys this bomb when not in view/camera render
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func explode():
	for body in $Area2D.get_overlapping_bodies():
		if body.has_method("kill"):
			body.kill()

	var particle = explosionParticle.instance()
	get_parent().add_child(particle)
	particle.global_position = position
	queue_free()
