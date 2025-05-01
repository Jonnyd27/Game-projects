extends NodeState

signal Paint_color(String : )

const gravity : int = 700

var clear_colors : String = "ffffff"
var selected_color : String 
@export var character_body_2d : CharacterBody2D
@export var Peirre : AnimatedSprite2D
@export var PaintBrush : AnimatedSprite2D
const speed = 100

func on_process(_delta : float):
	pass

func on_physics_process(delta : float):
	get_tree().create_timer(0.3).timeout.connect(change_color_timeout)
	var direction : float = GameInputEvents.movement_input()
	
	if direction:
		character_body_2d.velocity.x = direction * speed
	character_body_2d.move_and_slide()
	
	character_body_2d.velocity.y += gravity * delta
	
	selected_color = clear_colors

func change_color_timeout():
	Paint_color.emit(selected_color)
	transition.emit("idle")
	
func enter():
	pass
	#Peirre.play("Change_Color")
	#PaintBrush.play("Change_color")

func exit():
	pass
	#Peirre.stop()
	#PaintBrush.stop()
