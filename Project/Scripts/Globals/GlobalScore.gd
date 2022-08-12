extends Node

var savegame = File.new() #file
var save_path = "user://savegame.save" #place of the file
var save_data = {"highscore": 0} #variable to store data

var curr_score = 0

func _ready():
	if not savegame.file_exists(save_path):
		_create_save()

func _create_save():
	savegame.open(save_path, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()

func save_high_score(high_score):
	save_data["highscore"] = high_score
	savegame.open(save_path, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()

func read_high_score():
	savegame.open(save_path, File.READ)
	save_data = savegame.get_var()
	savegame.close()
	return save_data["highscore"]
	
func trigger_new_game():
	curr_score = 0
