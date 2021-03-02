extends Node2D


onready var animation_player = $AnimationPlayer

signal animation_end


func _ready():
	"""
	Apenas conecta os signals que ativam as animações. Nada de lógica de jogo
	no pescador, apenas no GameController
	"""
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
	animation_player.play("Lost")

func play_catch():
	animation_player.play("Gotcha")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Gotcha" or anim_name == "Lost":
		emit_signal("animation_end")
