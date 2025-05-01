extends AnimatedSprite2D

class_name Apothecary


@onready var apothocary: AnimatedSprite2D = $"."
var blue_paint: String = "blue_paint"
var red_paint: String = "red_paint"
var yellow_paint: String = "yellow_paint"
var player_near = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	apothocary.play("default")
	if !player_near:
			return
	if player_near:
		if GameInputEvents.Chat():
			$Apothecary_dialogue.start()


func _on_chat_detection_area_body_entered(body):
	player_near = true
		

func _on_chat_detection_area_body_exited(body):
	player_near = false

func make_paint():
	pass

func _on_apothecary_dialogue_blue_paint():
	Player.gained_paint(blue_paint)


func _on_apothecary_dialogue_red_paint():
	Player.gained_paint(red_paint)


func _on_apothecary_dialogue_yellow_paint():
	Player.gained_paint(yellow_paint)
