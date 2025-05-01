extends CharacterBody2D

@export var correct_color : String
var damage_amount : int = 10
@export var Enemy: AnimatedSprite2D


@export var blue_bar_amount : int 
@export var yellow_bar_amount : int 
@export var red_bar_amount : int 
@onready var red_paint_bar : ProgressBar = $PaintBar/RedPaintBar
@onready var yellow_paint_bar: ProgressBar = $PaintBar/YellowPaintBar
@onready var blue_paint_bar: ProgressBar = $PaintBar/BluePaintBar

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
var clear_colors : String = "ffffff"
var brown_color : String = "6f4c2e"

func _ready() -> void:
	blue_paint_bar.max_value = blue_bar_amount
	red_paint_bar.max_value = red_bar_amount
	yellow_paint_bar.max_value = yellow_bar_amount

func paint(paint_color, paint_amount):
	if paint_color == clear_colors:
		Clear_Paint_values()
		Enemy.modulate = clear_colors
		current_color = clear_colors
	if paint_color == blue_color:
		blue_paint_amount += paint_amount
		blue_paint_bar.value = blue_paint_amount
		if blue_paint_amount == blue_bar_amount:
			if current_color == orange_color:
				current_color = brown_color
				Enemy.modulate = brown_color
			elif current_color == yellow_color:
				current_color = green_color
				Enemy.modulate = green_color
			elif current_color == red_color:
				current_color = purple_color
				Enemy.modulate = purple_color
			else:
				current_color = blue_color
				Enemy.modulate = blue_color
	elif paint_color == red_color:
		red_paint_amount += paint_amount
		red_paint_bar.value = red_paint_amount
		if red_paint_amount == red_bar_amount:
			if current_color == green_color:
				current_color = brown_color
				Enemy.modulate = brown_color
			elif current_color == blue_color:
				current_color = purple_color
				Enemy.modulate = purple_color
			elif current_color == yellow_color:
				current_color = orange_color
				Enemy.modulate = orange_color
			else:
				current_color = red_color
				Enemy.modulate = red_color
	elif paint_color == yellow_color:
		yellow_paint_amount += paint_amount
		yellow_paint_bar.value = yellow_paint_amount
		if yellow_paint_amount == yellow_bar_amount:
			if current_color == purple_color:
				current_color = brown_color
				Enemy.modulate = brown_color
			elif current_color == blue_color:
				current_color = green_color
				Enemy.modulate = green_color
			elif current_color == red_color:
				current_color = orange_color
				Enemy.modulate = orange_color
			else: 
				current_color = yellow_color
				Enemy.modulate = yellow_color
	if current_color == correct_color:
		Enemy_restored()
	

func Clear_Paint_values():
	blue_paint_amount = 0
	red_paint_amount = 0
	yellow_paint_amount = 0
	blue_paint_bar.value = 0
	red_paint_bar.value = 0
	yellow_paint_bar.value = 0
	

func Enemy_restored():
	$".".set_deferred("collision_layer", 3)
	$HitBox.set_deferred("monitorable", false)
	$AttackArea.set_deferred("monitoring",false) #No more chasing
	get_tree().create_timer(5.0).timeout.connect(_on_death_animation_timer_timeout)

func _on_death_animation_timer_timeout():
	queue_free()
