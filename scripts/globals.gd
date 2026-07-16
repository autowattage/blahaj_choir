extends Node

var tilt = Vector3(0,3,0) # XYZ tilt from accelerometer
var squeezed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# faux pas tilt detection
	tilt += Vector3(Input.get_axis("left","right")*2,Input.get_axis("down","up")*2,0)
	tilt.y = clamp(tilt.y,0,100)
	tilt.x = clamp(tilt.x,-20,20)
	# faux pas squeeze detection
	squeezed = Input.is_action_pressed("squeeze")
