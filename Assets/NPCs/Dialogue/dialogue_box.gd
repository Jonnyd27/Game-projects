extends Control

class_name Apothecary_dialogue

signal blue_paint
signal red_paint
signal yellow_paint

@export_file("*.json") var d_file

static var dialogue_counter: int = 0
var dialogue = []
var current_dialogue_id = 0
var d_active = false

func _ready():
	$NinePatchRect.visible = false

func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()

func load_dialogue():
	if dialogue_counter == 0:
		var file = FileAccess.open("res://Assets/NPCs/Dialogue/Apothecary.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		dialogue_counter = 1
		blue_paint.emit()
		return content
	elif dialogue_counter == 1:
		var file = FileAccess.open("res://Assets/NPCs/Dialogue/Apothecary1.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content
	elif dialogue_counter == 2:
		var file = FileAccess.open("res://Assets/NPCs/Dialogue/ApothecaryYellowFlower.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		yellow_paint.emit()
		return content
	elif dialogue_counter == 3:
		var file = FileAccess.open("res://Assets/NPCs/Dialogue/ApothecaryRedFlower.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		dialogue_counter = 4
		red_paint.emit()
		return content
	elif dialogue_counter == 4:
		var file = FileAccess.open("res://Assets/NPCs/Dialogue/ApothecaryOutOfText.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content

func _input(event):
	if !d_active:
		return
	if GameInputEvents.Interact():
		next_script()

func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		d_active = false
		$NinePatchRect.visible = false
		return
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]["name"]
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]["text"]

static func has_red_flower():
	dialogue_counter = 3

static func has_yellow_flower():
	dialogue_counter = 2
