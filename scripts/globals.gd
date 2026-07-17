extends Node

var json_input = ""
var tilt = Vector3(0,3,0) # XYZ tilt from accelerometer
var squeezed = false
var http_request = HTTPRequest.new()
var hertz = 440.0
var tilt_init

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	#var error = http_request.request("https://api.github.com/repos/godotengine/godot/releases/latest")
	var error = http_request.request("http://172.20.10.2/")

func _http_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS && response_code == 200:
		#var values = "{\"x\":5,\"y\":5,\"z\":5}" #pretend like this is my output yeah?
		var dict = JSON.parse_string(body.get_string_from_utf8())
		if not tilt_init: # initla position of blahaj
			tilt_init = Vector3(dict["x"],dict["y"],dict["z"])
		if dict != null: #corrected tilt
			Globals.tilt = Vector3(dict["x"],dict["y"],dict["z"]) - tilt_init
		print("initial: ", tilt_init)
		print("detected: ", dict)
		print("corrected: ", Globals.tilt)
		Globals.tilt.x
		# json request a second time (infite loop)
		var error = http_request.request("http://172.20.10.2/")
	else:
		print("error in HTTP request: ", response_code)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# faux pas tilt detection
	tilt += Vector3(Input.get_axis("left","right")*2,Input.get_axis("down","up")*2,0)
	tilt.y = clamp(tilt.y,0,100)
	tilt.x = clamp(tilt.x,-30,30)
	# faux pas squeeze detection
	squeezed = Input.is_action_pressed("squeeze")
