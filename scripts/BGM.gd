extends Node
@export var bg_music : AudioStream = null

# Called when the node enters the scene tree for the first time.
func _ready():
	play()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func stop():
	SoundManager.stop_music()
	
func play():
	if bg_music:
		stop()
		SoundManager.play_music(bg_music)
	
