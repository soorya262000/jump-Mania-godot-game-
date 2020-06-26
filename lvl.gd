extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ff=null
onready var scene = preload("res://floor.tscn")
var runlvl=load("res://runlvl.tscn")
var shield=load("res://hsield.tscn")
var pos=Vector2(350,142)
var dd=false
var gf=null
var flrcount=0
signal jump
var highscoreshown=0
onready var exitdialog=$exitcanvas/game_exit
onready var dead_sequence_label=$dead_sequence_cnavas/ColorRect/dead_sequence_label
onready var jumpbutton=$CanvasLayer2/jump
onready var breakbutton=$CanvasLayer2/break
onready var batterylabel=$CanvasLayer/NinePatchRect2/batteries
onready var revive_sound_effect=$revive_sound
onready var dead_sequence=$dead_sequence_cnavas
signal breakfloor
onready var pplayer=$Player
onready var camera=$cam
onready var coinlabel=$CanvasLayer/NinePatchRect/coins
onready var dead_music=$AudioStreamPlayer2D
var winsize
var pausescene=load("res://pausescreen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().set_quit_on_go_back(false)
	dead_sequence.get_child(0).hide()
	winsize=get_viewport().size		
	$CanvasLayer2.get_child(0).hide()
	$CanvasLayer4.get_child(0).hide()
	#dead_sequence.hide()
	print(get_viewport().size.x)
	Globals.floorcount=0
	Globals.cooldown=0
	Globals.haspowerup=0
	Globals.poweruplife=0
	Globals.extralifeused=1
	Globals.playerstate="runlvlstart"
	Globals.lvltype=0
	Globals.batteries=0
	
	
	for i in range(16):
		
		
		
			ff=scene.instance()
			ff.name="floor"+str(flrcount)
			ff.floorno=flrcount
			#print(ff.name)
			flrcount+=1
			#connect("btnpressed",ff,"_on_Node2D_btnpressed")
		
			
			var tpos=pos+Vector2(0,150)
			pos=tpos
			#print(tpos)
			
			add_child(ff)
			ff.global_position=tpos
			#print(ff.name)
			#print(ff.global_position)
		
		
			#ff=runlvl.instance()
			#add_child(ff)
			#pos=pos+Vector2(-175,180)
			#ff.global_position=pos
			#pos=ff.get_node("Position2D").global_position+Vector2(20,0)
			#print(pos)
		
				
		
		
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_Back_pressed()
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_on_Back_pressed()
		
func _physics_process(delta):
	coinlabel.text=str(Globals.coins)
	batterylabel.text=str(Globals.batteries)
	if(Globals.isalive==1):
		if(Globals.lvltype==0):
			camera.position.y=pplayer.position.y
		if(Globals.lvltype==1):
			camera.position.x=pplayer.position.x
		


	
	
	

			
			
			
			
	
	
	
func _on_Back_pressed():
	get_tree().paused=true
	exitdialog.popup()
	
	


	


func _on_Player_nextfloor():
	Globals.cooldown=0
	#print("nextfloor")
	Globals.floorcount+=1
	#print(Globals.floorcount)
	
	if(Globals.save_data["floor"]<Globals.floorcount):
		if(highscoreshown==0):
			$CanvasLayer4.get_child(0).show()
			$CanvasLayer4/Control/AnimationPlayer.play("scalehigh")
			$CanvasLayer4/Control/highscore.play()
			highscoreshown=1
	#print("added")
	#print(pos)
	if(flrcount%25!=0):
		
		ff=scene.instance()
		ff.name="floor"+str(flrcount)
		ff.floorno=flrcount
		flrcount+=1
		#print(ff.name)	
		#connect("btnpressed",ff,"_on_Node2D_btnpressed")
		pos=pos+Vector2(0,150)
		#print(pos)
		add_child(ff)
		print(ff.name)
		ff.global_position=pos
	else:
		ff=runlvl.instance()
		
		ff.name="floor"+str(flrcount)
		ff.floorno=flrcount
		print(str(flrcount)+" special")
		flrcount+=1
		add_child(ff)
		pos=pos+Vector2(-175,180)
		ff.global_position=pos
		pos=ff.get_node("Position2D").global_position+Vector2(60,0)
		print(pos)
			
	
	
	
	#Globals.floorlist[Globals.iindex]=ff
	
	#print(ff.global_position)
	#print(ff)
	


func _on_Player_died():
	#dead_sequence.get_child(0).show()
	#dead_sequence.get_child(0).show()
	print("dead")
	Globals.coins+=(Globals.batteries*5)
	Globals.batteries=0
	if(Globals.save_data["floor"]<Globals.floorcount):
		Globals.save_data={"floor":Globals.floorcount,"coins":Globals.coins}
		Globals.save_play_data(Globals.savepath,{"floor":Globals.floorcount,"coins":Globals.coins})
		print(Globals.save_data)
	Globals.save_play_data(Globals.playerassetspath,{"coins":Globals.coins})	
	if(Globals.coins>(250*Globals.extralifeused)):
		dead_sequence.get_child(0).show()
		dead_sequence_label.text="Use "+str((250*Globals.extralifeused))+" coins for extra life?"
	else:
		dead_music.play()
	
		
	

	
	



	


func _on_TouchScreenButton_pressed():
	if(Globals.isalive==1):
		$CanvasLayer2.get_child(0).hide()
		self.add_child(pausescene.instance())
		get_tree().paused = true


func _on_game_start_pressed():	
	$CanvasLayer3.queue_free()
	$CanvasLayer2.get_child(0).show()
	


func _on_soundonoff_pressed():
	Globals.soundonoff=Globals.soundonoff^1


func _on_AudioStreamPlayer2D_finished():
	print("restart")
	self.get_tree().reload_current_scene()
	Globals.isalive=1
	Globals.floorcount=0
	






func _on_game_exit_confirmed():
	self.get_tree().quit()


func _on_game_exit_modal_closed():
	self.get_tree().paused=true
	



func _on_game_exit_hide():
	get_tree().paused=false


func _on_extralife_pressed():
	revive_sound_effect.play()
	Globals.coins-=(250*(Globals.extralifeused))
	Globals.extralifeused+=1
	Globals.save_play_data(Globals.playerassetspath,{"coins":Globals.coins})	
	Globals.cooldown=1
	Globals.isalive=1
	self.get_node("Player").get_node("fireposition").add_child(shield.instance())
	dead_sequence.get_child(0).hide()


func _on_noextralife_pressed():
	dead_sequence.get_child(0).hide()
	dead_music.play()
	
