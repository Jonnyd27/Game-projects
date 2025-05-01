class_name Level
extends Node2D

@export var player:Player
@export var paths:Array[Pathway]
var data:LevelDataHandoff

func _ready() -> void:
	player.disable()
	player.visible = false
	
	if data == null:
		enter_level()
	

func enter_level() ->void:
	if data != null:
		init_player_location()
	player.enable()
	_connect_to_paths()


func init_player_location() ->void:
	
	if data != null:
		for path in paths:
			if path.name == data.entry_path_name:
				player.position = path.get_player_entry_vector()
			#player.orient(data.move_dir)

func _on_player_entered_path(path: Pathway) -> void:
	_disconnect_from_paths()
	player.disable()
	player.queue_free()
	data = LevelDataHandoff.new()
	data.entry_path_name = path.entry_door_name
	data.move_dir = path.get_move_dir()
	set_process(false)

func _connect_to_paths() -> void:
	for path in paths:
		if not path.player_entered_door.is_connected(_on_player_entered_path):
			path.player_entered_door.connect(_on_player_entered_path)

func _disconnect_from_paths() -> void:
	for path in paths:
		if path.player_entered_door.is_connected(_on_player_entered_path):
			path.player_entered_door.disconnect(_on_player_entered_path)
