extends NodeState

@export var character_body_2d : CharacterBody2D


@export_category("Jump State")
@export var jump_height = -300
@export var Jump_Horizontal_speed: int = 800
@export var max_jump_horizontal_speed : int = 150


func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	if character_body_2d.is_on_floor():
		character_body_2d.velocity.y = jump_height

	character_body_2d.move_and_slide()
	
	#Transitioning states.
	
	if !character_body_2d.is_on_floor():
		transition.emit("fall")
	

func enter():
	pass

func exit():
	pass
