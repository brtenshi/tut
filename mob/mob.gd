extends RigidBody3D

signal died

var health = 2
var speed = randf_range(2.0, 4.0)

@onready var bat_model: Node3D = %bat_model
@onready var player = get_node("/root/Game/Player")
@onready var hurt: AudioStreamPlayer3D = %hurt
@onready var die: AudioStreamPlayer3D = %die



func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	direction.y = 0.0
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI/4


func take_damage():
	if health == 0:
		return
	
	bat_model.hurt()
	health -= 1
	%hurt.play()
	
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		var direction = -1.0 * global_position.direction_to(player.global_position)
		var random_upward_force = Vector3.UP * randf_range(1.0, 5.0)
		apply_central_impulse(direction * 10 + random_upward_force)
		%Timer.start()
		lock_rotation = false
		die.play()


func _on_timer_timeout():
	queue_free()
	died.emit()
