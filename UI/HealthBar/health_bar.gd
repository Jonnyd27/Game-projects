extends Node2D

@onready var health_bar: ProgressBar = $HealthBar

func _ready():
	HealthManager.on_health_change.connect(on_player_health_changed)
	

func on_player_health_changed(player_current_health : int):
	health_bar.value = player_current_health
