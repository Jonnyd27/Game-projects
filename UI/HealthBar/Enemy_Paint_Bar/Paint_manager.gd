extends Node

var current_paint

signal on_paint_change
	

func increase_paint(paint_color, paint_amount : int):
	on_paint_change.emit(paint_color, paint_amount)
