extends NodeState

signal Paint_color(String : )

const gravity : int = 1000

var blue_color : String = "2361ff"
var selected_color : String 
@export var character_body_2d : CharacterBody2D
@export var Peirre : AnimatedSprite2D
@export var PaintBrush : AnimatedSprite2D
@export var action_ready_sound: AudioStreamPlayer2D 
@export var action_ready: GPUParticles2D 

var speed = 100

@export var can_dash : bool = false
var is_dashing : bool = false

func on_process(_delta : float):
	pass

func on_physics_process(delta : float):
	get_tree().create_timer(0.1).timeout.connect(change_color_timeout)
	var direction : float = GameInputEvents.movement_input()
	
	if direction:
		character_body_2d.velocity.x = direction * speed
	character_body_2d.move_and_slide()
	
	character_body_2d.velocity.y += gravity * delta
	
	selected_color = blue_color
	
	#Slash Left/Right
	if GameInputEvents.Slash_left() or GameInputEvents.Slash_right():
		transition.emit("slash")
	#Up_Slash State.
	if GameInputEvents.Slash_up():
		transition.emit("upslash")
	#Up_Down State.
	if GameInputEvents.Slash_down():
		transition.emit("downslash")
	#fall state
	if !character_body_2d.is_on_floor():
		transition.emit("fall")
	#jump state
	if GameInputEvents.Jump_input():
		transition.emit("jump")
	#dash state.
	if GameInputEvents.Dash() and can_dash == true and !is_dashing:
		is_dashing = true
		transition.emit("dash")
		get_tree().create_timer(2.0).timeout.connect(can_dash_timer)

func can_dash_timer():
	action_ready_sound.play()
	action_ready.set_deferred("modulate", "2361ff")
	action_ready.set_deferred("emitting", true)
	is_dashing = false

func change_color_timeout():
	Paint_color.emit(selected_color)
	transition.emit("idle")
	
func enter():
	pass
	Peirre.play("Idle")
	PaintBrush.play("Idle")

func exit():
	pass
	#Peirre.stop()
	#PaintBrush.stop()
