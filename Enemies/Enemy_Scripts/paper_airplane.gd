extends CharacterBody2D

@export var correct_color : String
var damage_amount : int = 10
var blue_color : String = "2361ff"
var red_color : String = "d50000"
var yellow_color : String = "e7e700"
#var purple_color : String = "d200d2"
#var green_color : String = "00b600"
#var orange_color : String = "ef6d00"


func paint(color):
	modulate = color
	if color == correct_color:
		Enemy_death()
	elif color == blue_color:
		print("I don't wanna be blue")
	elif color == red_color:
		print("I don't wanna be red")
	elif color == yellow_color:
		print("I don't wanna be yellow")

func Enemy_death():
	$AttackArea.set_deferred("monitoring",false) #No more chasing
	$AnimatedSprite2D.play("Death")
	get_tree().create_timer(1.0).timeout.connect(death_timer_timout)

func death_timer_timout():
	queue_free()
