extends Particles2D

onready var audio=$AudioStreamPlayer2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if(Globals.soundonoff==1):
		audio.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Globals.haspowerup==0):
		self.queue_free()
#	pass


func _on_AudioStreamPlayer2D_finished():
	Globals.haspowerup=0
	Globals.poweruplife=0
	self.get_parent().queue_free()
