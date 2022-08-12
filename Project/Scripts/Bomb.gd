extends KinematicBody2D

const frag_angles = [45, 90, 135, 180, 225, 270]

var velocity = Vector2()
var explosionParticle = preload("res://Scenes/BombExplodeParticle.tscn")
var fragment = preload("res://Scenes/FragmentScene.tscn")

var has_frag: bool

func start(pos, speed, frag = false):
	self.position = pos
	velocity = Vector2(0, speed)
	
	has_frag = frag
	if has_frag:
		$FragIcon.visible = true

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
	_kill_all_in_radius()
	_spawn_exploding_particle()
	if has_frag:
		_spawn_frags()
	queue_free()
	
func _kill_all_in_radius():
	for body in $Area2D.get_overlapping_bodies():
		if body.has_method("kill"):
			body.kill()

func _spawn_exploding_particle():
	var particle = explosionParticle.instance()
	get_parent().add_child(particle)
	particle.global_position = position
	
func _spawn_frags():
	var random = RandomNumberGenerator.new()
	random.randomize()
	for i in range(frag_angles.size()):
		random.randomize()
		var new_frag = fragment.instance()
		new_frag.start(self.global_position, frag_angles[i])
		self.get_parent().add_child(new_frag)
	pass
