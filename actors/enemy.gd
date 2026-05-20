extends CharacterBody3D


func deal_damage(amount = 10, pos=self.position):
	var label = Label.new()
	label.text = str(amount)
	label.position = get_viewport().get_camera_3d().unproject_position(pos)
	
	var timer = Timer.new()
	timer.wait_time = 1
	timer.autostart=true
	timer.timeout.connect(func ():
		label.queue_free()
	)
	
	label.add_child(timer)
	self.add_child(label)
	pass
