extends NodeState

@export var character_body_2d : CharacterBody2D
@export var sprite_2d : Sprite2D
@export var correct_color : Sprite2D
@export var audio_stream_player_2d: AudioStreamPlayer2D 

const gravity : int = 500
var jump_height : int = -175
const jump_speed : int = 150
var dir = 1

func on_process(_delta : float):
	pass

func on_physics_process(delta : float):
	if character_body_2d.is_on_floor():
		character_body_2d.velocity.x = 0
	else:
		if dir < 0:
			sprite_2d.flip_h = true
			correct_color.flip_h = true
		else:
			sprite_2d.flip_h = false
			correct_color.flip_h = false
		character_body_2d.velocity.y += gravity * delta
		character_body_2d.velocity.x = dir * jump_speed
	character_body_2d.move_and_slide()

func enter():
	pass

func exit():
	pass

func hop():
	audio_stream_player_2d.play()
	dir = choose([1, -1])
	character_body_2d.velocity.y += jump_height

func _on_hop_timer_timeout() -> void:
	var random_time = [1,2.5,4]
	random_time.shuffle()
	$"../../Hop_Timer".wait_time = random_time.front()
	hop()

func choose(array):
	array.shuffle()
	dir = array.front()
	return dir 
