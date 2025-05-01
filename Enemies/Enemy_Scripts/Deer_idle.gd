extends NodeState

@export var character_body_2d : CharacterBody2D
@export var sprite_2d : AnimatedSprite2D
@export var correct_color : AnimatedSprite2D
@export var audio_stream_player_2d: AudioStreamPlayer2D 


func on_process(_delta : float):
	pass


func on_physics_process(delta : float):
	pass


func enter():
	pass
	#sprite_2d.play()

func exit():
	pass


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		transition.emit("attack")
