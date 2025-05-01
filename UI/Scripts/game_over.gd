extends CanvasLayer



func _on_paint_again_pressed():
	var max_health = 100
	HealthManager.increase_health(max_health)
	get_tree().reload_current_scene()
	queue_free()


func _on_give_up_pressed():
	var max_health = 100
	HealthManager.increase_health(max_health)
	GameManager.main_menu()
	queue_free()
