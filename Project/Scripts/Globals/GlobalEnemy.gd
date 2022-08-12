extends Node

var power_up_spawn_chance: float = 0
var SPAWN_CHANCE_INCREMENT: float = 0.075

func trigger_no_power_up_spawned():
	power_up_spawn_chance += SPAWN_CHANCE_INCREMENT
	
func trigger_power_up_spawned():
	power_up_spawn_chance = 0
	 
func trigger_new_game():
	power_up_spawn_chance = 0
