extends Node

var frag_active = false
var FRAG_DURATION: float = 10
var frag_timer:float = 0

func _process(delta):
	if frag_active:
		frag_timer += delta
		if frag_timer >= FRAG_DURATION:
			frag_active = false
	
func activate_frag():
	frag_active = true
	frag_timer = 0
