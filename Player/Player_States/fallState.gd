extends NodeState

@export var action_ready: GPUParticles2D 
@export var character_body_2d : CharacterBody2D
@export var Peirre : AnimatedSprite2D
@export var PaintBrush : AnimatedSprite2D
@export var action_ready_sound: AudioStreamPlayer2D 

@onready var fall: Node = $"."
@export var land_sound: AudioStreamPlayer2D 
@export var Jump_Horizontal_speed: int = 30
@export var max_jump_horizontal_speed : int = 150
@export var can_spin : bool = false
@export var can_dash : bool = false
const Gravity : int = 1000
var is_dashing : bool = false
var is_spinning : bool = false

func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	
	var direction : float = GameInputEvents.movement_input()
	
	if !character_body_2d.is_on_floor():
		character_body_2d.velocity.x += direction * Jump_Horizontal_speed
		character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)
	
	if direction > 0:
		Peirre.flip_h = false
		PaintBrush.flip_h = false
	elif direction < 0:
		Peirre.flip_h = true
		PaintBrush.flip_h = true
	
	character_body_2d.velocity.y += Gravity * delta
	character_body_2d.move_and_slide()
	
	#transitioning states
	
	#idle state
	if character_body_2d.is_on_floor():
		transition.emit("idle")
	
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
	#if GameInputEvents.Spin() and can_spin == true and !is_spinning:
		#is_spinning = true
		#transition.emit("spin")
		#get_tree().create_timer(3.0).timeout.connect(can_spin_timer)

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
	Peirre.play("Fall")
	PaintBrush.play("Fall")

func exit():
	Peirre.stop()
	PaintBrush.stop()
	land_sound.play()

func can_dash_timer():
	action_ready_sound.play()
	action_ready.set_deferred("modulate", "2361ff")
	action_ready.set_deferred("emitting", true)
	is_dashing = false
