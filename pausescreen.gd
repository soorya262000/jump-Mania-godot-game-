extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var floorr=$CanvasLayer/Label2


# Called when the node enters the scene tree for the first time.
func _ready():
	if(Globals.save_data["floor"]>Globals.floorcount):
		floorr.text=str(Globals.save_data["floor"])
		
	else:
		floorr.text=str(Globals.floorcount)
		
	
			
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	print("hi")
	
	 # Replace with function body.


func _on_playbtn_pressed():
	self.get_parent().get_node("CanvasLayer2").get_child(0).show()
	self.queue_free()
	get_tree().paused = false
	
