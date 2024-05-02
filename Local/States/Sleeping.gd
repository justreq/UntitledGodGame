extends State

func _physics_process(_delta):
	if not visible:
		return
	
	print("Sleeping")
