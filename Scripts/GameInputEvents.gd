class_name GameInputEvents
extends Node

static func movement_input() -> float:
	var direction : float = Input.get_axis("Left", "Right")
	return direction

static func Jump_input() -> bool:
	var jump_input : bool = Input.is_action_just_pressed("jump")
	return jump_input

static func Slash_left()  -> bool:
	var slash_left : bool = Input.is_action_just_pressed("left_attack")
	return slash_left

static func Slash_right() -> bool:
	var slash_right : bool = Input.is_action_just_pressed("right_attack")
	return slash_right

static func Slash_up() -> bool:
	var slash_up : bool = Input.is_action_just_pressed("up_attack")
	return slash_up
	
static func Slash_down() -> bool:
	var slash_down : bool = Input.is_action_just_pressed("down_attack")
	return slash_down

static func Dash() -> bool:
	var dash : bool = Input.is_action_just_pressed("Dash")
	return dash

static func Change_Color() -> bool:
	var change_color = Input.is_action_just_pressed("Change_Color")
	return change_color

static func Blue_Paint() -> bool:
	var blue_paint = Input.is_action_just_pressed("blue_paint")
	return blue_paint

static func Red_Paint() -> bool:
	var red_paint = Input.is_action_just_pressed("red_paint")
	return red_paint

static func Yellow_Paint() -> bool:
	var yellow_paint = Input.is_action_just_pressed("yellow_paint")
	return yellow_paint

static func Clear_Paint() -> bool:
	var clear_paint = Input.is_action_just_pressed("clear_paint")
	return clear_paint

static func Interact() -> bool:
	var interact = Input.is_action_just_pressed("interact")
	return interact

static func Chat() -> bool:
	var chat = Input.is_action_just_pressed("Chat")
	return chat

static func Spin() -> bool:
	var spin = Input.is_action_just_pressed("spin_jump")
	return spin
