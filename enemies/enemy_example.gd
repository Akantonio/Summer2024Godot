extends RigidBody2D


func take_damage():
	$AnimatedSprite.animation = "Hit"
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	$AnimatedSprite2D
	t.queue_free()
	queue_free()
	
