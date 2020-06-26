extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bulletscene=load("res://bulletscene.tscn")
onready var pos=$Position2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass


func _on_Timer_timeout():
	var bb=bulletscene.instance()
	bb.position.x=self.pos.position.x
	self.add_child(bb)
