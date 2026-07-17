extends Control

@onready var synth: AudioStreamPlayer = $synth
var sample_hz = 22000 #22050.0 # Keep the number of samples to mix low, GDScript is not super fast.
var phase = 0.0
var playback: AudioStreamPlayback = null # Actual playback stream, assigned in _ready().
var master_bus = AudioServer.get_bus_index("Master")

func _fill_buffer():
	var increment = Globals.hertz / sample_hz

	var to_fill = playback.get_frames_available()
	while to_fill > 0:
		playback.push_frame(Vector2.ONE * sin(phase * TAU)) # Audio frames are stereo.
		phase = fmod(phase + increment, 1.0)
		to_fill -= 1

func _process(_delta):
	_fill_buffer()
	Globals.hertz = 698.46+Globals.tilt.x*26
	AudioServer.set_bus_mute(master_bus, not Globals.squeezed)

func _ready():
	# Setting mix rate is only possible before play().
	synth.stream.mix_rate = sample_hz
	synth.play()
	playback = synth.get_stream_playback()
	# `_fill_buffer` must be called *after* setting `playback`,
	# as `fill_buffer` uses the `playback` member variable.
	_fill_buffer()
