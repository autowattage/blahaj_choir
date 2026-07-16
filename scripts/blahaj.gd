class_name blahaj extends AnimatedSprite2D

@onready var mouth: AnimatedSprite2D = $mouth
@onready var left_eye: AnimatedSprite2D = $"left eye"
@onready var right_eye: AnimatedSprite2D = $"right eye"

var tilt = Vector3() # 6 axis tilt
var squeeze_timer = 0 # how long blahaj is squeezed

func _ready() -> void:
	left_eye.play("idle")
	right_eye.play("idle")
	mouth.set_frame(3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	detect_squeeze(delta)
	# faux pas tilt detection
	tilt += Vector3(Input.get_axis("left","right"), Input.get_axis("up","down"),0)
	
func detect_squeeze(delta) -> void:
	# blahaj is squeezed
	if Input.is_action_pressed("squeeze"):
		mouth.set_frame(0)
		squeeze_timer += delta
	elif Input.is_action_just_released("squeeze"):
		mouth.play()
		squeeze_timer = 0
	
	# vibrate on squeeze
	i
	left_eye.play("squeezed") if squeeze_timer>1 else left_eye.play("idle")
	right_eye.play("squeezed") if squeeze_timer>1 else right_eye.play("idle")
	
