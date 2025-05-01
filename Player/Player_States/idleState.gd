extends NodeState

@export var action_ready: GPUParticles2D 
@export var character_body_2d : CharacterBody2D
@export var Peirre : AnimatedSprite2D
@export var PaintBrush : AnimatedSprite2D
@export var action_ready_sound: AudioStreamPlayer2D 
@export_category("Physics Friction")
@export var slow_down_speed : int = 20
@export var can_spin : bool = false
var is_spinning : bool = false

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0, slow_down_speed)
	
	character_body_2d.move_and_slide()
	#transitioning states
	
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
	#run state
	var direction : float = GameInputEvents.movement_input()
	if direction and character_body_2d.is_on_floor():
		transition.emit("run")
	#jump state
	if GameInputEvents.Jump_input():
		transition.emit("jump")
	#Spin jump State
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
	Peirre.play("Idle")
	PaintBrush.play("Idle")

func exit():
	Peirre.stop()
	PaintBrush.stop()

func can_spin_timer():
	action_ready_sound.play()
	action_ready.set_deferred("modulate", "e7e700")
	action_ready.set_deferred("emitting", true)
	is_spinning = false
