extends Node3D


@onready var round_timer: Timer = %round_timer
@onready var label = %Label
var player_score = 0
var round = 1
signal new_round

func _ready() -> void:
	round_timer.start()

func increase_score():
	player_score+=1
	label.text = "Score: " + str(player_score)

func _on_mob_spawner_3d_mob_spawned(mob: Variant) -> void:
	mob.died.connect(func on_mob_died():
		increase_score()
		poof(mob.global_position)
		)
	poof(mob.global_position)
	

func poof(mob_global_position):
	const SMOKE_PUFF = preload("uid://cjk3frr43yesb")
	var poof = SMOKE_PUFF.instantiate()
	add_child(poof)
	poof.global_position = mob_global_position


func _on_killplane_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene.call_deferred()


func _on_timer_timeout() -> void:
	round += 1
	label.text = "Round: " + str(round)
	new_round.emit()
