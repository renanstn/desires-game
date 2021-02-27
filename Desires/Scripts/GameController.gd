extends Node


onready var pull_timer = $PullTime
onready var next_fish_timer = $NextFishTimer
export(NodePath) var fishermen_path
var fishermen : Node2D
enum states {
	IDLE,
	ALERT,
	CATCH
}
var actual_state
const MIN_FISH_TIME = 5
const MAX_FISH_TIME = 15

signal play_idle
signal play_alert
signal play_lost
signal play_catch


func _ready():
	fishermen = get_node(fishermen_path)
	emit_signal("play_idle")
	randomize()
	actual_state = states.IDLE
	var next_fish = rand_range(MIN_FISH_TIME, MAX_FISH_TIME)
	print("Próximo peixe em:")
	print(next_fish)
	next_fish_timer.wait_time = next_fish
	next_fish_timer.start()


func _process(_delta):
	if Input.is_action_just_pressed("Pull"):
		if actual_state == states.ALERT:
			emit_signal("play_catch")
			print("pegou!")
			pull_timer.stop()
			actual_state = states.IDLE
			emit_signal("play_idle")
			var next_fish = rand_range(MIN_FISH_TIME, MAX_FISH_TIME)
			print("Próximo peixe em:")
			print(next_fish)
			next_fish_timer.wait_time = next_fish
			next_fish_timer.start()
		else:
			emit_signal("play_lost")
			print("...")


func _on_PullTime_timeout():
	print("Perdeu...")
	actual_state = states.IDLE
	emit_signal("play_idle")
	var next_fish = rand_range(MIN_FISH_TIME, MAX_FISH_TIME)
	print("Próximo peixe em:")
	print(next_fish)
	next_fish_timer.wait_time = next_fish
	next_fish_timer.start()


func _on_NextFishTimer_timeout():
	actual_state = states.ALERT
	emit_signal("play_alert")
	pull_timer.start()
	print("!!!")
