extends Node2D

@export var Enemy: AnimatedSprite2D

@onready var paint_bar: Node2D = $PaintBar

@export var blue_bar_amount : int 
@export var yellow_bar_amount : int 
@export var red_bar_amount : int 
@onready var red_paint_bar: ProgressBar = $RedPaintBar
@onready var yellow_paint_bar: ProgressBar = $YellowPaintBar
@onready var blue_paint_bar: ProgressBar = $BluePaintBar

var current_color : String
var blue_paint_amount : int 
var yellow_paint_amount : int
var red_paint_amount : int
var blue_color : String = "2361ff"
var red_color : String = "d50000"
var yellow_color : String = "e7e700"
var purple_color : String = "d200d2"
var green_color : String = "00b600"
var orange_color : String = "ef6d00"

func _ready():
	PaintManager.on_paint_change.connect(on_Enemy_paint_value_change)
	blue_paint_bar.max_value = blue_bar_amount
	red_paint_bar.max_value = red_bar_amount
	yellow_paint_bar.max_value = yellow_bar_amount

func on_Enemy_paint_value_change(paint_color, paint_amount):
	if paint_color == blue_color:
		blue_paint_amount += paint_amount
		blue_paint_bar.value = blue_paint_amount
		if blue_paint_amount == blue_bar_amount:
			if current_color == yellow_color:
				Enemy.modulate = green_color
			elif current_color == red_color:
				Enemy.modulate = purple_color
			else:
				current_color = blue_color
				Enemy.modulate = blue_color
	if paint_color == red_color:
		red_paint_amount += paint_amount
		red_paint_bar.value = red_paint_amount
		if red_paint_amount == red_bar_amount:
			if current_color == blue_color:
				Enemy.modulate = purple_color
			elif current_color == yellow_color:
				Enemy.modulate = orange_color
			else:
				current_color = red_color
				Enemy.modulate = red_color
	if paint_color == yellow_color:
		yellow_paint_amount += paint_amount
		yellow_paint_bar.value = yellow_paint_amount
		if yellow_paint_amount == yellow_bar_amount:
			if current_color == blue_color:
				Enemy.modulate = green_color
			elif current_color == red_color:
				Enemy.modulate = orange_color
			else: 
				current_color = yellow_color
				Enemy.modulate = yellow_color
