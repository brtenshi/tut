extends StaticBody3D

const enemy = preload("res://mob/mob.gd")
var radius = 30.0
var damage = 1.0
var target = null
var targetsList = Array([], TYPE_OBJECT, "Node", null)
var type = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	%DetectionRadius.scale = (radius, radius, radius)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy_search()
	if target != null:
		look_at(target.global_position)
		if %BulletTimer.is_stopped():
			shoot_bullet()


func enemy_search():
	#maybe put on timer to not target switch too fast?
	if targetsList != []:
		for element in targetsList:
			if target == null:
				target = element
			else: if global_position.distance_to(element.global_position) < global_position.distance_to(target.global_position):
				target = element
	else:
		target = null



func shoot_bullet():
	const BULLET_3D = preload("uid://elhildpxvgrg")
	var new_bullet = BULLET_3D.instantiate()
	%Marker3D.add_child(new_bullet)
	#need to change to set bullet parameters based on upgrades
	
	new_bullet.global_transform = %Marker3D.global_transform
	
	%BulletTimer.start()

func spawn_tower():
	pass

func _on_detection_radius_body_entered(body: Node3D) -> void:
		targetsList.append(body)


func _on_detection_radius_body_exited(body: Node3D) -> void:
	targetsList.erase(body)
	if targetsList == []:
		target = null
