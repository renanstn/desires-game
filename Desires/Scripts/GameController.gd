extends Node


onready var vara = get_node("Vara")
onready var boia = get_node("Boia")

onready var pull_timer = $PullTime

enum states {
	IDLE,
	ALERT,
	CATCH
}
var actual_state


func _ready():
	randomize()
	actual_state = states.IDLE


func _process(delta):
	var chances = randf()
	if chances < 0.01:
		actual_state = states.ALERT
		pull_timer.start()
		print("!!!")
	if Input.is_action_just_pressed("Pull"):
		if actual_state == states.ALERT:
			print("pegou!")
			actual_state = states.IDLE
		else:
			print("...")


func _on_PullTime_timeout():
	actual_state = states.IDLE
