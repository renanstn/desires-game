extends Node2D


onready var animation_player = $AnimationPlayer


func _ready():
	var game_controller = get_tree().get_root().find_node("GameController", true, false)
	if game_controller:
		game_controller.connect("play_idle", self, "play_idle")
		game_controller.connect("play_alert", self, "play_alert")
		game_controller.connect("play_lost", self, "play_lost")
		game_controller.connect("play_catch", self, "play_catch")

func play_idle():
	animation_player.play("Idle")

func play_alert():
	animation_player.play("Alert")

func play_lost():
	pass

func play_catch():
	pass
