extends Node

var PIERRES_HOUSE = preload("res://Levels/PierresHouse.tscn")
var PAUSE_MENU = preload("res://UI/Pause_Menu.tscn")
var MAIN_MENU = preload("res://UI/Main_Menu.tscn")
var GAME_OVER = preload("res://UI/Game_Over.tscn")


func _ready():
	RenderingServer.set_default_clear_color(Color(0.1,0.06,0.12,1))

func start_game():
	if get_tree().paused:
		continue_game()
		return
	
	transition_to_scene(PIERRES_HOUSE.resource_path)

func exit_game():
	get_tree().quit()

func pause_game():
	get_tree().paused = true
	
	var pause_menu_screen_instance = PAUSE_MENU.instantiate()
	get_tree().get_root().add_child(pause_menu_screen_instance)

func continue_game():
	get_tree().paused = false

func main_menu():
	var main_menu_screen_instance = MAIN_MENU.instantiate()
	get_tree().get_root().add_child(main_menu_screen_instance)

func game_over():
	var game_over_screen_instance = GAME_OVER.instantiate()
	get_tree().get_root().add_child(game_over_screen_instance)

func transition_to_scene(scene_path):
	#Scene Transition
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(scene_path)
