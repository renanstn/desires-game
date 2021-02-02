extends Node


onready var vara = get_node("Vara")
onready var boia = get_node("Boia")
onready var pull_timer = $PullTime
onready var next_fish_timer = $NextFishTimer

enum states {
	IDLE,
	ALERT,
	CATCH
}
var actual_state
const MIN_FISH_TIME = 5
const MAX_FISH_TIME = 15


func _ready():
	randomize()
	actual_state = states.IDLE
	var next_fish = rand_range(MIN_FISH_TIME, MAX_FISH_TIME)
	print("Próximo peixe em:")
	print(next_fish)
	next_fish_timer.wait_time = next_fish
	next_fish_timer.start()


func _process(delta):
	if Input.is_action_just_pressed("Pull"):
		if actual_state == states.ALERT:
			print("pegou!")
			pull_timer.stop()
			actual_state = states.IDLE
			var next_fish = rand_range(MIN_FISH_TIME, MAX_FISH_TIME)
			print("Próximo peixe em:")
			print(next_fish)
			next_fish_timer.wait_time = next_fish
			next_fish_timer.start()
		else:
			print("...")


func _on_PullTime_timeout():
	print("Perdeu...")
	actual_state = states.IDLE
	var next_fish = rand_range(MIN_FISH_TIME, MAX_FISH_TIME)
	print("Próximo peixe em:")
	print(next_fish)
	next_fish_timer.wait_time = next_fish
	next_fish_timer.start()


func _on_NextFishTimer_timeout():
	actual_state = states.ALERT
	pull_timer.start()
	print("!!!")
