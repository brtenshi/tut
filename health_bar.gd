extends TextureProgressBar


@export var character: Node3D
@export var character_height = 0.0
#@export var min_scale = 0.11
#@export var max_scale = 2.0
@export var character_size = 100.0
var camera: Camera3D

func _ready():
	camera = get_viewport().get_camera_3d()
	
	if character and "max_health" in character:
		max_value = character.max_health
		value = character.max_health
	if character and "health" in character:
		value = character.health

func _process(delta):
	if not character or not camera:
		return
	
	if character and "health" in character:
		value = character.health
		
	if (!camera.is_position_behind(character.global_position + Vector3(0, character_height, 0))):
		visible = true
		var screen_pos = camera.unproject_position(character.global_position + Vector3(0, character_height, 0))
		global_position = screen_pos
		global_position += Vector2(-get_rect().size.x / 2, 0)
		
		var distance = camera.global_transform.origin.distance_to(character.global_transform.origin)
		#var scale_factor = clamp(1.0 - distance/size, min_scale, max_scale)
		#scale = Vector2(scale_factor, scale_factor)
		scale = Vector2(character_size/distance, character_size/distance)
