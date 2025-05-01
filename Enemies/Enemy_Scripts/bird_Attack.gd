extends NodeState

@export var character_body_2d : CharacterBody2D
@export var sprite_2d : AnimatedSprite2D
@export var correct_color : AnimatedSprite2D
@export var audio_stream_player_2d: AudioStreamPlayer2D 
var horizontal_speed : int = 150
var vertical_speed : int = 300

var max_speed : int = 150 

var player : CharacterBody2D

func on_process(_delta : float):
	pass


func on_physics_process(delta : float):
	var direction_x : int
	var direction_y : int
	if character_body_2d.global_position.x > player.global_position.x:
		direction_x = -1
	elif character_body_2d.global_position.x < player.global_position.x:
		direction_x = 1
	if character_body_2d.global_position.y > player.global_position.y:
		direction_y = -1
	elif character_body_2d.global_position.y < player.global_position.y:
		direction_y = 1

	
	character_body_2d.velocity.x += direction_x * horizontal_speed * delta
	character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, - max_speed, max_speed)
	character_body_2d.velocity.y += direction_y * vertical_speed * delta
	character_body_2d.velocity.y = clamp(character_body_2d.velocity.y, - max_speed, max_speed)
	character_body_2d.move_and_slide()
	

func enter():
	print("attack")
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D

func exit():
	pass


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		transition.emit("idle")
