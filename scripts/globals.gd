extends Node

var json_input = ""
var tilt = Vector3(0,3,0) # XYZ tilt from accelerometer
var squeezed = false
var http_request = HTTPRequest.new()

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	var error = http_request.request("https://placehold.co/512.png")
	
func _http_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Image couldn't be downloaded. Try a different image.")

	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")

	var texture = ImageTexture.create_from_image(image)

	# Display the image in a TextureRect node.
	var texture_rect = TextureRect.new()
	add_child(texture_rect)
	texture_rect.texture = texture
	#error = http_request.request("192.168.8.X") #do later
	#print("http request completed :3s")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# faux pas tilt detection
	tilt += Vector3(Input.get_axis("left","right")*2,Input.get_axis("down","up")*2,0)
	tilt.y = clamp(tilt.y,0,100)
	tilt.x = clamp(tilt.x,-20,20)
	# faux pas squeeze detection
	squeezed = Input.is_action_pressed("squeeze")
