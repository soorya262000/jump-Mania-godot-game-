extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(int) var floorno
onready var floorlabel=$Label
# Called when the node enters the scene tree for the first time.
func _ready():
	#print(str(self.floorno)+"")
	self.floorlabel.text="Floor-"+str(self.floorno)
	pass # Replace with function body.





func _on_Area2D_area_entered(area):
	if(area.name=="enemydetector"):
		self.get_parent().get_node("missileholder").queue_free()
		Globals.lvltype=0
		Globals.playerstate="runlvlstart"
		Globals.floorcount+=1
		Globals.cooldown=1
		
		
		
