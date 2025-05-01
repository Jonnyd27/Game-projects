extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var speed : int
var player : CharacterBody2D
var max_speed : int

func on_process(_delta : float):
	pass

func on_physics_process(delta : float):
	var direction : int
	if character_body_2d.global_position > player.global_position:
		direction = -1
	elif character_body_2d.global_position < player.global_position:
		direction = 1
	
	character_body_2d.velocity.x += direction * speed * delta
	character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, - max_speed, max_speed)
	character_body_2d.move_and_slide()


func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	max_speed = speed + 20

func exit():
	pass


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		transition.emit("idle")
