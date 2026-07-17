extends AnimatedSprite2D

@onready var mouth: AnimatedSprite2D = $mouth
@onready var animplayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation = "middle"
	mouth.animation = "middle"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouth.visible = Globals.squeezed
	animplayer.play("jump") if Input.is_action_pressed("squeeze") else animplayer.stop()
	
	# set x-axis image
	flip_h = Globals.tilt.y<0
	mouth.flip_h = Globals.tilt.y<0
	if abs(Globals.tilt.y) < 5:
		animation = "middle"
		mouth.animation = "middle"
	elif abs(Globals.tilt.y) < 16:
		animation = "side"
		mouth.animation = "side"
	else:
		animation = "sideside"
		mouth.animation = "sideside"
	# set y-axis image
	frame = -Globals.tilt.x/12
	mouth.frame = -Globals.tilt.x/12
