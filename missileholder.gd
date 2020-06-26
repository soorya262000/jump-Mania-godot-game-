extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var camera
var rand_generate=RandomNumberGenerator.new()
onready var timer=$Timer
var missile=load("res://missile.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	camera=self.get_parent().get_node("cam")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var missilepos=rand_generate.randi_range(1,5)
	var miss=rand_generate.randi_range(1,5)
	if(missilepos==2):
		$Timer.wait_time=1
	elif(missilepos==1 or missilepos==4):
		$Timer.wait_time=2	
	else:
		$Timer.wait_time=3	
	if(Globals.isalive==1):
		var ff=missile.instance()
		var lvlobj=self.get_parent()
		var pos=self.get_parent().get_node("Player").global_position
		lvlobj.add_child(ff)
		ff.global_position.x=pos.x-400
		if(missilepos==1):
			ff.global_position.y=camera.position.y+(-50)
		elif(missilepos==2):
			ff.global_position.y=camera.position.y+(-10)
		elif(missilepos==3):
			ff.global_position.y=camera.position.y+(-20)
		else:
			ff.direction=-1
			ff.global_position.x=pos.x+400
			ff.scale.x=-0.2
			if(miss==1):
				ff.global_position.y=camera.position.y+(-50)
			elif(miss==3 or miss==4):
				ff.global_position.y=camera.position.y+(-20)
			else:
				ff.global_position.y=camera.position.y+(-10)		
			
			
				
	
	
