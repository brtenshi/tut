extends RigidBody3D

signal died

var max_health = 2.0
var health = 2.0
var speed = 6.0

@onready var enemy_model: Node3D = %enemy_model
@onready var target = get_node("/root/Game/main_tower")



func _physics_process(delta):
	var direction = global_position.direction_to(target.global_position)
	direction.y = 0.0
	linear_velocity = direction * speed
	enemy_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) 


func take_damage():
	if health == 0:
		return
	
	enemy_model.hurt()
	health -= 1
	
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		var direction = -1.0 * global_position.direction_to(target.global_position)
		var random_upward_force = Vector3.UP * randf_range(1.0, 5.0)
		apply_central_impulse(direction * 10 + random_upward_force)
		%Timer.start()
		lock_rotation = false

func _on_timer_timeout():
	queue_free()
	died.emit()

func _on_body_entered(body: Node) -> void:
	#queue_free()
	if body.has_method("take_enemy_damage"):
		body.take_enemy_damage()
		queue_free()
