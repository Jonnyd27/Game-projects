extends NodeState

@export var character_body_2d : CharacterBody2D
@export var Peirre : AnimatedSprite2D
@export var PaintBrush : AnimatedSprite2D
@export var dash: AudioStreamPlayer2D 

const dash_time = 0.5
const dash_speed = 350


func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):

	character_body_2d.velocity.y = 0
	var direction : float = GameInputEvents.movement_input()

	if direction:
		character_body_2d.velocity.x = direction * dash_speed
	character_body_2d.move_and_slide()
	
	if direction > 0:
		Peirre.flip_h = false
		PaintBrush.flip_h = false
	elif direction < 0:
		Peirre.flip_h = true
		PaintBrush.flip_h = true
	
func enter():
	dash.play()
	get_tree().create_timer(dash_time).timeout.connect(dash_timeout)
	Peirre.play("Dash")
	PaintBrush.play("Dash")

func exit():
	Peirre.stop()
	PaintBrush.stop()

func dash_timeout():
	transition.emit("idle")
