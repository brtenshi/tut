extends Node3D


@onready var cylinder: MeshInstance3D = %Cylinder
@onready var torus: MeshInstance3D = %Torus

func change_color(r, g, b):
	cylinder.get_surface_override_material(0).albedo_color = Color(r, g, b)
	torus.get_surface_override_material(0).albedo_color = Color(r, g, b)
