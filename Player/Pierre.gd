extends CharacterBody2D
class_name Player

static var has_blue_paint: bool = true
static var has_red_paint: bool = true
static var has_yellow_paint: bool = true

@onready var invulnerability_flashing: AnimationPlayer = $Pierre/Invulnerability_Flashing
@onready var body: Player = $"."
@onready var has_yellow_flower: bool = false
@onready var has_red_flower: bool = false
@onready var pierre: AnimatedSprite2D = $Pierre
@onready var paint_color: AnimatedSprite2D = $Pierre/Paint_color
@onready var hit_box: Area2D = $Pierre/SideHitArea
@onready var upward_hit_box: Area2D = $Pierre/UpHitArea
@onready var downward_hit_box: Area2D = $Pierre/DownHitArea
@export var input_enabled:bool = true
var blue_color : String = "2361ff"
var red_color : String = "d50000"
var yellow_color : String = "e7e700"
@onready var hit_sound: AudioStreamPlayer2D = $Pierre/Sound_Effects/HitSound


var is_invulnerable = false
var dark_grey : String = "787878"
var darker_grey : String = "2c2c2c"
var current_color 
var paint_amount : int = 10

func _ready():
	pass

func player_death():
	GameManager.game_over()
	queue_free()

#Pierre gets hit here and reacts to enemy collision bodies
func _on_hurt_box_body_entered(body: CharacterBody2D):
	if body.is_in_group("Enemy"):
		if !is_invulnerable:
			is_invulnerable = true
			hit_sound.play()
			HealthManager.decrease_health(body.damage_amount)
			invulnerability()
#Function to inact invulnerability if player isn't dead
func invulnerability():
	if HealthManager.current_health == 0:
			player_death()
	else:
		invulnerability_flashing.play("Invulnerable")
		get_tree().create_timer(2.0).timeout.connect(invulnerability_timeout)
		if HealthManager.current_health <= 50 && HealthManager.current_health >= 25:
			pierre.modulate = dark_grey
		elif HealthManager.current_health <= 25:
			pierre.modulate = darker_grey
#Timer for Invulnerability, and modulate color towards black as health depletes
func invulnerability_timeout():
	is_invulnerable = false
	if HealthManager.current_health <= 50 && HealthManager.current_health >= 25:
		pierre.modulate = dark_grey
	elif HealthManager.current_health <= 25:
		pierre.modulate = darker_grey
#Timer for attack monitering to align with animation swing
func _physics_process(_delta):
	if GameInputEvents.Slash_left() or GameInputEvents.Slash_right():
		hit_box.set_deferred("monitoring",true)
		get_tree().create_timer(0.4).timeout.connect(_on_attack_duration_timeout)
		
	if GameInputEvents.Slash_up():
		upward_hit_box.set_deferred("monitoring",true)
		get_tree().create_timer(0.4).timeout.connect(slash_up_timeout)
	#
	if GameInputEvents.Slash_down():
		downward_hit_box.set_deferred("monitoring",true)
		get_tree().create_timer(0.4).timeout.connect(slash_down_timeout)
	
	move_abilities()
#Pierres monitering value for his paint attack
func _on_hit_box_area_entered(area):
	var overlapping_objects = hit_box.get_overlapping_areas()
	
	for hitbox in overlapping_objects:
		var parent = hitbox.get_parent()
		if parent is CharacterBody2D:
			parent.paint(current_color, paint_amount)

func _on_upward_hit_box_area_entered(area):
	var overlapping_objects = upward_hit_box.get_overlapping_areas()
	
	for UpHitBox in overlapping_objects:
		var parent = UpHitBox.get_parent()
		print(parent)
		if parent is CharacterBody2D:
			parent.paint(current_color, paint_amount)

func _on_downward_hit_box_area_entered(area):
	var overlapping_objects = downward_hit_box.get_overlapping_areas()
	
	for DownHitBox in overlapping_objects:
		var parent = DownHitBox.get_parent()
		if parent is CharacterBody2D:
			parent.paint(current_color, paint_amount)
			if !body.is_on_floor():
				down_bounce()
#Bounce off of enemies when downward attack
func down_bounce():
	velocity.y = -200

func _on_attack_duration_timeout() -> void:
	hit_box.set_deferred("monitoring",false)

func slash_up_timeout() -> void:
	upward_hit_box.set_deferred("monitoring",false)

func slash_down_timeout():
	downward_hit_box.set_deferred("monitoring",false)
#Functions to check and pass the current color of Pierres paint brush onto the enemy.
func _on_red_paint_color(selected_color):
	if has_red_paint:
		current_color = selected_color
		paint_color.modulate = current_color

func _on_blue_paint_color(selected_color):
	if has_blue_paint:
		current_color = selected_color
		paint_color.modulate = current_color

func _on_yellow_paint_color(selected_color):
	if has_yellow_paint:
		current_color = selected_color
		paint_color.modulate = current_color
#Clears the color bars of the enemy
func _on_clear_paint_color(selected_color):
	current_color = selected_color
	paint_color.modulate = current_color

func disable():
	input_enabled = false

func enable():
	input_enabled = true
	visible = true
#A check to see if the character has receieved a color from the Apothecary
static func gained_paint(paint):
	if paint == "blue_paint":
		has_blue_paint = true
	if paint == "red_paint":
		has_red_paint = true
	if paint == "yellow_paint":
		has_yellow_paint = true

func Has_Red_Flower():
	Apothecary_dialogue.has_red_flower()
	has_red_flower = true
	print("have flower")

func Has_Yellow_Flower():
	Apothecary_dialogue.has_yellow_flower()
	has_yellow_flower = true
	print("have flower")
#Function to allow different move abilities when a specific color is selected
func move_abilities():
	if current_color == blue_color:
		$StateMachine/Fall.set_deferred("can_dash", true)
		$StateMachine/Run.set_deferred("can_dash", true)
	else:
		$StateMachine/Fall.set_deferred("can_dash", false)
		$StateMachine/Run.set_deferred("can_dash", false)
	if current_color == yellow_color:
		$StateMachine/Idle.set_deferred("can_spin", true)
		#$StateMachine/Fall.set_deferred("can_spin", true)
		$StateMachine/Run.set_deferred("can_spin", true)
	else:
		$StateMachine/Idle.set_deferred("can_spin", false)
		#$StateMachine/Fall.set_deferred("can_spin", false)
		$StateMachine/Run.set_deferred("can_spin", false)
