extends AnimatedSprite2D

@onready var mouth: AnimatedSprite2D = $mouth
@onready var audioplayer: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animplayer: AnimationPlayer = $AnimationPlayer

var tilt = Vector3(0,3,0) # XYZ tilt from accelerometer
var squeezed = false

func _ready() -> void:
	animation = "middle"
	mouth.animation = "middle"
	mouth.visible = squeezed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# faux pas tilt detection
	tilt += Vector3(Input.get_axis("left","right"),Input.get_axis("down","up"),0)
	tilt.y = clamp(tilt.y,0,20)
	tilt.x = clamp(tilt.x,-8,8)
	# faux pas squeeze detection
	squeezed = Input.is_action_pressed("squeeze")
	mouth.visible = Input.is_action_pressed("squeeze")
	#animplayer.play("jump") if Input.is_action_pressed("squeeze") else animplayer.stop()
	
	
	# set x-axis frame
	flip_h = tilt.x<0
	mouth.flip_h = tilt.x<0
	if abs(tilt.x) < 2:
		animation = "middle"
		mouth.animation = "middle"
	elif abs(tilt.x) < 6:
		animation = "side"
		mouth.animation = "side"
	else:
		animation = "sideside"
		mouth.animation = "sideside"
	# set y-axis frame
	frame = tilt.y/4
	mouth.frame = tilt.y/4	
