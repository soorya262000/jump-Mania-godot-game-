extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var coinmagnet=load("res://coinmagnet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if(area.get_parent().name=="Player"):
		var pos=area.get_parent().get_node("fireposition")
		print(pos.get_children())
		pos.add_child(coinmagnet.instance())
		self.queue_free()
