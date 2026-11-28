extends Node3D


signal enemy_spawned(enemy)

@onready var marker_3d: Marker3D = %Marker3D
@onready var timer: Timer = %Timer
@onready var model: Node3D = %enemy_spawner_model
@onready var game = get_node("/root/Game")
@export var enemy_to_spawn: PackedScene = null
var active = false
var round = 1.0
@export var start_round = 1.0
@export var wait_time = 1.0
@export var speed_increase_threshhold = 2.0
@export var speed_increase = 0.5


func _ready():
	game.connect("new_round", _on_game_new_round)
	%Timer.wait_time = wait_time
	model.change_color(1, 1, 1)

func _on_timer_timeout() -> void:
	if (round >= start_round):
		active = true
	if active:
		model.change_color(1, 0, 0)
		var new_enemy = enemy_to_spawn.instantiate()
		add_child(new_enemy)
		new_enemy.global_position = marker_3d.global_position
		
		enemy_spawned.emit(new_enemy)


func _on_game_new_round() -> void:
	round += 1
	if (fmod(round, speed_increase_threshhold) == 0):
		%Timer.wait_time *= speed_increase
