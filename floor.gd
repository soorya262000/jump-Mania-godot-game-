extends Node2D
onready var bottom=$enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var floorno
var enemy1 = load("res://src/Actors/Enemy.tscn")
var enemy2=load("res://enemy2.tscn")
var coin1=load("res://coin1.tscn")
var coin2=load("res://coin2.tscn")
var coin3=load("res://coin3.tscn")
var powerup=load("res://rocketpowerup.tscn")
var magnetpowerup=load("res://magnetpowerup.tscn")
onready var floorlabel=$Label
var rand_generate=RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rand_generate.randomize()
	floorlabel.text="Floor-"+str(self.floorno)
	#print(self.name)
	var ff;
	if(self.name!="floor1"):
		var randint=rand_generate.randi_range(1,4)
		if(randint==1):
			ff=enemy1.instance()
			ff.name=self.name+"Enemy"
			self.bottom.add_child(ff)
			ff.global_position=ff.global_position+Vector2(-20,-50)
		elif(randint==2):
			var enemypos=rand_generate.randi_range(1,3)
			ff=enemy2.instance()
			self.bottom.add_child(ff)
			ff.name=self.name+"Enemy"
			if(enemypos==1):
				ff.global_position=ff.global_position+Vector2(-40,-45)
			else:
				ff.scale.x=-1.6
				ff.global_position=ff.global_position+Vector2(180,-45)
		else:
			var coinint=rand_generate.randi_range(1,4)
			var coinpos=rand_generate.randi_range(1,4)
			if(coinint==1):
				ff=coin1.instance()
				ff.name=self.name+"Coin"
				
			elif(coinint==2):				
				ff=coin2.instance()
				ff.name=self.name+"Coin"
			else:
				ff=coin3.instance()
				ff.name=self.name+"Coin"
			self.bottom.add_child(ff)	
			if(coinpos==1):
				ff.global_position=ff.global_position+Vector2(-40,-50)			
			elif(coinpos==2):
				ff.global_position=ff.global_position+Vector2(60,-50)			
			else:
				ff.global_position=ff.global_position+Vector2(140,-50)			
		
		var powerposrand=rand_generate.randi_range(1,21)
		print(((floor(self.floorno/25)+1)*25)-self.floorno)
		if((powerposrand==5 or powerposrand==10 or powerposrand==17) and self.name!="floor1" and ((floor(self.floorno/25)+1)*25)-self.floorno>5):
			var poweruppos=rand_generate.randi_range(1,3)
			var poweruptype=rand_generate.randi_range(1,3)
			var ss
			if(poweruptype==1):
				ss=powerup.instance()
			else:
				ss=magnetpowerup.instance()	
			self.bottom.add_child(ss)		
			if(poweruppos==1):
				ss.global_position=ss.global_position+Vector2(-10,-45)
			else:
				ss.global_position=ss.global_position+Vector2(160,-45)
					
			
		
		
		
	#else:
		#var ss=powerup.instance()
		#ss.global_position=ss.global_position+Vector2(-40,-50)
		#self.bottom.add_child(ss)
		
	
		
	#print(ff)
		
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
	


func _on_VisibilityNotifier2D_screen_exited():
	#print("exited")
	if(self.global_position.y<0):
		queue_free()

	
func screenhandler():
	pass	

	
