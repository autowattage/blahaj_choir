extends NinePatchRect

@onready var blahj: TextureRect = $MarginContainer/blahj

var notelocations = [.39, .11 ]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(Globals.hertz)
	if Globals.hertz > 800.25:
		blahj.offset_transform_position_ratio.y = -.15 * (Globals.hertz-349.23)/349.23
	else:
		blahj.offset_transform_position_ratio.y = .39 -.15 * (Globals.hertz-349.23)/349.23
