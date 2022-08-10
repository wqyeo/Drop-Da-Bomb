extends Node2D

var fragment_is_active = false

func _ready():
	$FragmentStateLabel.percent_visible = 0

func _process(delta):
	if GlobalPlayer.frag_active and !fragment_is_active:
		fragment_is_active = true
		$FragmentStateAnim.play("ShowFrag")
	elif !GlobalPlayer.frag_active and fragment_is_active:
		fragment_is_active = false
		$FragmentStateAnim.play("HideFrag")
