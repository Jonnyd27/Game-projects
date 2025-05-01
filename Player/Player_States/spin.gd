extends NodeState

@export var character_body_2d : CharacterBody2D
@export var Peirre : AnimatedSprite2D
@export var PaintBrush : AnimatedSprite2D
@export var spin: AudioStreamPlayer2D

const spin_time: float = 0.5
const spin_height: int = -400
const max_vertical_speed: int = 200
const spin_jump_speed: int = 50

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	var direction = GameInputEvents.movement_input()
	if direction:
		character_body_2d.velocity.x = direction * spin_jump_speed
	
	character_body_2d.velocity.y += spin_height
	character_body_2d.velocity.y = clamp(character_body_2d.velocity.y, -max_vertical_speed, max_vertical_speed)
	character_body_2d.move_and_slide()



func enter():
	spin.play()
	get_tree().create_timer(spin_time).timeout.connect(spin_timeout)
	#Peirre.play("Spin")
	#PaintBrush.play("Spin")


func exit():
	pass

func spin_timeout():
	transition.emit("idle")
