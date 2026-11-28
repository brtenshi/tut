extends StaticBody3D

var max_health = 10.0
var health = max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func take_enemy_damage():
	if health == 0:
		return
		
	#hurt animation here
	health -= 1
		
	if health == 0:
			get_tree().reload_current_scene.call_deferred()
