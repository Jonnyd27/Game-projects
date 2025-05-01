extends NodeState

const gravity : int = 700
@export var slow_down_speed : int = 10
@export var character_body_2d : CharacterBody2D
@export var Peirre : AnimatedSprite2D
@export var PaintBrush : AnimatedSprite2D
@export var hit_box: Area2D 
@export var speed : int = 75
@export var Jump_Horizontal_speed: int = 800
@export var max_jump_horizontal_speed : int = 150
@onready var slash_sound: AudioStreamPlayer2D = $"../../Pierre/Sound_Effects/SlashSound"


func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	#character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0, slow_down_speed)
	character_body_2d.velocity.y += gravity * delta
	
	var direction : float = GameInputEvents.movement_input()
	character_body_2d.velocity.x = direction * speed
	
	if !character_body_2d.is_on_floor():
		character_body_2d.velocity.x += direction * Jump_Horizontal_speed
		character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)
	
	character_body_2d.move_and_slide()
	
	if direction > 0:
		Peirre.flip_h = false
		PaintBrush.flip_h = false
	elif direction < 0:
		Peirre.flip_h = true
		PaintBrush.flip_h = true
		
func enter():
	slash_sound.play()
	get_tree().create_timer(0.4).timeout.connect(Downslash_timeout)
	Peirre.play("Down_Slash")
	PaintBrush.play("Down_Slash")

func exit():
	Peirre.stop()
	PaintBrush.stop()

func Downslash_timeout():
	transition.emit("idle")
