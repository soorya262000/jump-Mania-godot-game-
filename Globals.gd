extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score=0
var gamestate=0
var coins=0
var haspowerup=0
var poweruptype=0
var poweruplife=0
var soundonoff=1
var isalive=1
var floorcount=0
var floorlist=[]
var iindex=-1
var cooldown=0
var battery=0
var playerstate="runlvlstart"
var lvltype=0
var save_data
var load_data
var batteries
var extralifeused
var savepath="user://play.data"
var playerassetspath="user://playerassets.data"
# Called when the node enters the scene tree for the first time.
func _ready():
	extralifeused=1
	var fileval
	save_data = load_play_data(savepath)
	fileval=load_play_data(playerassetspath)
	
	#save_data={"floor":5,"coins":0}
	if(save_data==null):
		save_data={"floor":0,"coins":0}
		print(save_data)
		save_play_data(savepath, save_data)
	print(save_data)
	if(fileval==null):
		coins=0
		save_play_data(playerassetspath,{"coins":coins})
	else:
		coins=fileval["coins"]	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func save_play_data(path, data):
	var f = File.new()
	f.open(path, File.WRITE)
	f.store_var(data)
	f.close()

func load_play_data(path):
	var f = File.new()
	if f.file_exists(path):
		f.open(path, File.READ)
		var data = f.get_var()
		f.close()
		return data
	return null
	
	

