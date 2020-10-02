extends Node2D


# shooting enemy
var bulletscene=load("res://bulletscene.tscn")
onready var pos=$Position2D

func _ready():
	pass # Replace with function body.



func _process(delta):	
	pass


func _on_Timer_timeout():
	var bb=bulletscene.instance()
	bb.position.x=self.pos.position.x
	self.add_child(bb)
