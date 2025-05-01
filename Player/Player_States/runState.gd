extends NodeState

@export var character_body_2d : CharacterBody2D
@export var Peirre : AnimatedSprite2D
@export var PaintBrush : AnimatedSprite2D
@export var can_spin : bool = false
@export var action_ready: GPUParticles2D 
@export var action_ready_sound: AudioStreamPlayer2D 

@export var can_dash : bool = false
@export_category("Run State")
@export var speed : int = 75
@export var max_horizontal_speed : int = 125
const gravity : int = 1000
var is_dashing : bool = false
var is_spinning : bool = false

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	#character_body_2d.velocity.y += gravity * delta
	var direction : float = GameInputEvents.movement_input()
	
	if direction:
		character_body_2d.velocity.x += direction * speed
		character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_horizontal_speed, max_horizontal_speed)
		
	
	if direction > 0:
		Peirre.flip_h = false
		PaintBrush.flip_h = false
	elif direction < 0:
		Peirre.flip_h = true
		PaintBrush.flip_h = true
	
	character_body_2d.move_and_slide()
#transitioning states
	
#jump state
	if GameInputEvents.Jump_input():
		transition.emit("jump")
#idle state
	if direction == 0:
		transition.emit("idle")
#fall state
	if !character_body_2d.is_on_floor():
		transition.emit("fall")
#slash state.
	if GameInputEvents.Slash_left() or GameInputEvents.Slash_right():
		transition.emit("slash")
#Up_Slash State.
	if GameInputEvents.Slash_up():
		transition.emit("upslash")
	#Up_Slash State.
	if GameInputEvents.Slash_down():
		transition.emit("downslash")
#dash state.
	if GameInputEvents.Dash() and can_dash == true and !is_dashing:
		is_dashing = true
		transition.emit("dash")
		get_tree().create_timer(2.0).timeout.connect(can_dash_timer)
		#spin state.
	if GameInputEvents.Spin() and can_spin == true and !is_spinning:
		is_spinning = true
		transition.emit("spin")
		get_tree().create_timer(3.0).timeout.connect(can_spin_timer)
#Change_color state
		#Blue
	if GameInputEvents.Blue_Paint():
		transition.emit("blue")
		#red
	if GameInputEvents.Red_Paint():
		transition.emit("red")
		#yellow
	if GameInputEvents.Yellow_Paint():
		transition.emit("yellow")
		#clear
	if GameInputEvents.Clear_Paint():
		transition.emit("clear")

func enter():
	Peirre.play("Walking")
	PaintBrush.play("Walking")

func exit():
	Peirre.stop()
	PaintBrush.stop()

func can_dash_timer():
	action_ready_sound.play()
	action_ready.set_deferred("modulate", "2361ff")
	action_ready.set_deferred("emitting", true)
	is_dashing = false

func can_spin_timer():
	action_ready_sound.play()
	action_ready.set_deferred("modulate", "e7e700")
	action_ready.set_deferred("emitting", true)
	is_spinning = false
