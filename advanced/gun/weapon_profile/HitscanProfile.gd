extends WeaponProfile

class_name HitscanProfile

@export var spread_degrees = 5
@export var casts_per_shot = 1
@export var cast_range = 100

func fire(source:Node3D,direction:Vector3):
	for i in range(casts_per_shot):
		var ray_forward = direction\
		.rotated(Vector3.RIGHT,deg_to_rad(randf_range(0,spread_degrees)))\
		.rotated(direction,deg_to_rad(randf_range(0,360)))
		var start = source.global_position
		var end = start + (ray_forward*cast_range)
		var results = raycast(source,start,end)
		if not results.is_empty():
			var body = results.get("collider")
			end = results.get("position")
			if body.has_method("deal_damage"):
				body.deal_damage(base_damage,end)
		create_simple_tracer(source.get_tree().root,start,end)
	pass

func raycast(source:Node3D,start:Vector3,end:Vector3):
	var space_state = source.get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(start,end)
	query.collide_with_bodies=true
	return space_state.intersect_ray(query)

@export var tracer_lifetime = 0.25

func create_simple_tracer(root,start,end):
	var immediate_mesh = ImmediateMesh.new()
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	immediate_mesh.surface_set_color(Color(1,1,0.5))
	immediate_mesh.surface_add_vertex(start)
	immediate_mesh.surface_add_vertex(end)
	immediate_mesh.surface_end()
	
	var material = StandardMaterial3D.new()
	material.vertex_color_use_as_albedo = true
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.material_override = material
	
	var timer = Timer.new()
	timer.wait_time = tracer_lifetime
	timer.autostart = true
	timer.timeout.connect(func ():
		mesh_instance.queue_free()
	)
	
	mesh_instance.add_child(timer)
	root.add_child(mesh_instance)
