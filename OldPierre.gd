extends CharacterBody2D


var gravity = ProjectSettings.get_setting(("physics/2d/default_gravity"))
var color = ("#2361ff")
var playerdamage = 10.0
const normalspeed = 150.0
const Jump_Velocity = -300.0
const dash_speed = 900.0
const dashlength = .1
@onready var is_invulnerable = false
@onready var timer = $"dashtimer"
@onready var PlayerPosition = $Marker2D
@onready var anim_player = $Marker2D/CharacterMovement/PlayerAnimation
@export var is_dash_on_cooldown = false
@export var attacking = false
@export var friction := 20
#This function processes whether a player input is an attack input, then proceeds to the attack function.

func _physics_process(delta):
	if Input.is_action_pressed("left_attack"):
			PlayerPosition.scale.x = abs(PlayerPosition.scale.x) * -1
			attacking = true
			anim_player.play("Attack")
		
	if Input.is_action_pressed("right_attack"):
			PlayerPosition.scale.x = abs(PlayerPosition.scale.x)
			attacking = true
			anim_player.play("Attack")

	if Input.is_action_pressed("up_attack"):
		attacking = true
		anim_player.play("Up_attack")
	
	if Input.is_action_just_pressed("Dash"):
		if is_dash_on_cooldown == false:
			is_dash_on_cooldown = true
			start_dash(dashlength)
			anim_player.play("Dash")

	var speed = dash_speed if is_dashing() else normalspeed
	#Get Horizontal movement
	var direction = Input.get_axis("Left", "Right")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = Jump_Velocity

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
	
	$Marker2D/GPUParticles2D.modulate = Color(color)

	update_animation()
	move_and_slide()

#This is the function that allows the player to be hit
func hit(damage, knockbackPower, enemyVelocity):
	if !is_invulnerable:
		$Invulnerable.start()
		is_invulnerable = true
		knowckback(enemyVelocity, knockbackPower)
		$HealthBar.value -= damage
		if $HealthBar.value <= 0:
			die()
#This is the function that kills the player if his health reaches zero.
func die():
	$".".queue_free()
#This allows for animations to play out regardless of order, (I need to look into animation layer functions.
func update_animation():
	if !attacking:
		if velocity.x != 0:
			if Input.is_action_pressed("Left"):
				$Marker2D.scale.x = abs($Marker2D.scale.x) * -1
			if Input.is_action_pressed("Right"):
				$Marker2D.scale.x = abs($Marker2D.scale.x)
			anim_player.play("Running_Right")
		else:
			anim_player.play("Idle")
		
		if velocity.y < 0:
			anim_player.play("Jumping")

func _on_attack_area_area_entered(area):
	#areas that overlap during animation get hit.
	var overlapping_objects = $Marker2D/AttackArea.get_overlapping_areas()
	#This calls what is overlaping the attacks hitbox as a parent and plays there hit function.
	for hitbox in overlapping_objects:
		#var parent = hitbox.get_parent()
		if area.get_parent() is CharacterBody2D:
			area.get_parent().hit(playerdamage, color)

func start_dash(dur):

	$dashtimer.wait_time = dur
	$dashtimer.start()
	$DashCooldown.start()

func is_dashing():
	return !$dashtimer.is_stopped()

func _on_upward_attack_area_area_entered(area):
	var overlapping_objects = $Marker2D/UpwardAttackArea.get_overlapping_areas()
	#This calls what is overlaping the attacks hitbox as a parent and plays there hit function.
	for hitbox in overlapping_objects:
		if area.get_parent() is CharacterBody2D:
			area.get_parent().hit(playerdamage, color)

func knowckback(enemyVelocity: Vector2, knockbackPower):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()

func _on_invulnerable_timeout():
	is_invulnerable = false

func _on_dash_cooldown_timeout():
	is_dash_on_cooldown = false
