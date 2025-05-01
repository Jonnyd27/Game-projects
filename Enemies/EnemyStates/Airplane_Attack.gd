extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var speed : int
var player : CharacterBody2D
var max_speed : int

func on_process(_delta : float):
	pass


func on_physics_process(_delta : float):
	character_body_2d.velocity = character_body_2d.global_position.direction_to(player.global_position) * speed
	character_body_2d.velocity.y = clamp(character_body_2d.velocity.y, - max_speed, max_speed)
	
	if character_body_2d.global_position > player.global_position:
		animated_sprite_2d.flip_h = true
	elif character_body_2d.global_position < player.global_position:
		animated_sprite_2d.flip_h = false
	
	character_body_2d.move_and_slide()


func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	print("Airplane Engaged")
	max_speed = speed + 10

func exit():
	pass


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		transition.emit("idle")
