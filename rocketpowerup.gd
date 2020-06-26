extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var powerupscene=load("res://fireparticle.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	print(area.name)
	if(area.get_parent().name=="Player"):
		var pos=area.get_parent().get_node("fireposition")
		pos.add_child(powerupscene.instance())
		Globals.haspowerup=1
		Globals.cooldown=0
		Globals.poweruplife=4
		self.queue_free()
		
		
