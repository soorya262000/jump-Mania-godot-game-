class_name Player
extends Actor


const FLOOR_DETECT_DISTANCE = 20.0

export(String) var action_suffix = ""

onready var platform_detector = $PlatformDetector
onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var firepos=$fireposition
var shield=load("res://hsield.tscn")
var missileholder=load("res://missileholder.tscn")
#onready var enemydetectorright=$enemydetectorright
#onready var enemydetectorleft=$enemydetectorleft
var xconst=1;
var state=0

signal nextfloor
signal died
var flr="floor0"
func _ready():
	pass
	

func _physics_process(_delta):
	if(Globals.isalive==1):
		if(platform_detector.is_colliding()):		
			var tar=platform_detector.get_collider()
			if tar.name=="runlvl" and Globals.lvltype==0:
				print("lvl changed")
				Globals.lvltype=1
			
				
		#print(Globals.lvltype)		
		if(Globals.lvltype==0):
			if(Globals.haspowerup==0):
				#var enemy=enemydetectorleft.get_collider()
				#var enemy1=enemydetectorright.get_collider()
			
				if is_on_wall():
					#print("hi")
					xconst=-xconst
				var direction = get_direction()
				var is_jump_interrupted 
				if(state==1):
					is_jump_interrupted = Input.is_action_just_released("jump" + action_suffix) and _velocity.y < 0
				if(state==2):
					is_jump_interrupted=Input.is_action_just_released("ui_up") and _velocity.y < 0
				#is_jump_interrupted=false
				_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
			   
				var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
				var is_on_platform = platform_detector.is_colliding()
				
				_velocity = move_and_slide(
					_velocity,Vector2(0,-1)
				)
			
				# When the character’s direction changes, we want to to scale the Sprite accordingly to flip it.
				# This will make Robi face left or right depending on the direction you move.
				if direction.x != 0:
					sprite.scale.x = 1.3 if direction.x > 0 else -1.3
					
			
				# We use the sprite's scale to store Robi’s look direction which allows us to shoot
				# bullets forward.
				# There are many situations like these where you can reuse existing properties instead of
				# creating new variables.
				var is_shooting = false
			
			
				var animation = get_new_animation(is_shooting)
				animation_player.play(animation)
			else:
			
				
				var en
				var direction=Vector2(0,0)
				var target = platform_detector.get_collider()
				if $ensqaushright.is_colliding():
					en=$ensqaushright.get_collider()
					print(en.name)
		
					if(Globals.soundonoff==1):
						$kill.play()
					Globals.batteries+=1
					en.get_parent().queue_free()
				
				if $ensquashleft.is_colliding():
					en=$ensquashleft.get_collider()
					print(en.name)			
					if(Globals.soundonoff==1):
						$kill.play()
					Globals.batteries+=1	
					en.get_parent().queue_free()
					
				if target!=null:
					target=target.get_parent().get_parent().get_parent()
					if(Globals.soundonoff==1):
						$explode.play()
					#print(flr+" "+target.get_parent().name)
					target.get_parent().get_node("enemy").queue_free()
					target.queue_free()
					emit_signal("nextfloor")
					Globals.poweruplife-=1
					if(Globals.poweruplife<=0):
						Globals.cooldown=1
						Globals.haspowerup=0
						var powerupshield=shield.instance()
						firepos.add_child(powerupshield)
				_velocity = calculate_move_velocity(_velocity, direction, speed, false)	
				var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO		
				_velocity = move_and_slide(
					_velocity,Vector2(0,-1)
				)	
			
		else:
			if(Globals.playerstate=="runlvlplay"):			
				#print("runlvlplay")
				var direction=get_direction()
				var is_jump_interrupted = Input.is_action_just_released("ui_up" + action_suffix) and _velocity.y < 0
				_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
				
				_velocity = move_and_slide(
						_velocity,Vector2(0,-1)
					)
				if direction.x != 0:
					sprite.scale.x = 1.3 if direction.x > 0 else -1.3
				var is_shooting = false
				var animation = get_new_animation(is_shooting)
				animation_player.play(animation)	
			elif(Globals.playerstate=="runlvlstart"):			
				if(xconst==-1):
					xconst=1	
				Globals.playerstate="runlvlplay"	
				var missholder=missileholder.instance()
				#print("added holder")
				self.get_parent().add_child(missholder)
	
	else:
		animation_player.play("crouch")			
				
			


func get_direction():
	
	var target = platform_detector.get_collider()
	var en
	if(Globals.lvltype==0):
		
		if $ensqaushright.is_colliding():
			en=$ensqaushright.get_collider()
			#print(en.name)
			state=0		
			if(Globals.soundonoff==1):
				$kill.play()
			Globals.batteries+=1	
			en.get_parent().queue_free()
			
		if $ensquashleft.is_colliding():
			en=$ensquashleft.get_collider()
			#print(en.name)	
			state=0
			if(Globals.soundonoff==1):
				$kill.play()
			Globals.batteries+=1	
			en.get_parent().queue_free()
			
			
			
		if target != null and target.name!="runlvllimiter":		
			
			if state==1:			
				target=target.get_parent().get_parent()
				if(Globals.soundonoff==1):
					$explode.play()
				#print(flr+" "+target.get_parent().name)
				
				state=0
				if(flr!=target.get_parent().get_parent().name):
					flr=target.get_parent().get_parent().name
					emit_signal("nextfloor")
				target.queue_free()	
			elif(state==2):
				state=0
				
		
		
			
	var jump=Input.is_action_just_pressed("jump" + action_suffix)
	var jumpnotbreak=Input.get_action_strength("ui_up")
	if jump and platform_detector.is_colliding() and is_on_floor():
		state=1	
	elif(jumpnotbreak and platform_detector.is_colliding() and is_on_floor()):
		state=2	
	if(Globals.lvltype==1):
		state=2	
	if(jump or jumpnotbreak):
		if(!$Jump.is_playing() and Globals.soundonoff==1):
			$Jump.play()
	var ans= Vector2(
		xconst if is_on_floor() or state==1 or state==2 else 0,
		-1 if is_on_floor() and (jump or jumpnotbreak) and platform_detector.is_colliding() else 0
	)
	#print(ans)
	return ans


# This function calculates a new velocity whenever you need it.
# It allows you to interrupt jumps.
func calculate_move_velocity(
		linear_velocity,
		direction,
		speed,
		is_jump_interrupted
	):
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
	#print(direction.y*speed.y)
	if direction.y != 0.0:
		velocity.y =speed.y*direction.y
		#print("velocity")
		#print(velocity.y)
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity


func get_new_animation(is_shooting = false):
	var animation_new = ""
	if is_on_floor():
		animation_new = "run" if abs(_velocity.x) > 0.1 else "idle"
	else:
		animation_new = "falling" if _velocity.y > 0 else "jumping"
	if is_shooting:
		animation_new += "_weapon"
	return animation_new






func _on_enemydetector_body_entered(body):
	#print(body.name)
	if "Enemy" in body.name and Globals.haspowerup!=1  and Globals.cooldown!=1:
		Globals.isalive=0
		emit_signal("died")
		#self.queue_free()
		pass
	 


func _on_enemydetector_area_entered(area):
	if("bullet" in area.name and Globals.haspowerup!=1 and Globals.cooldown!=1 and Globals.isalive==1):
		print("bullet hit")
		Globals.isalive=0
		emit_signal("died")
		#self.queue_free()
	
	if("missilearea" in area.name and Globals.isalive==1 and Globals.cooldown!=1):
		Globals.isalive=0
		emit_signal("died")
		#self.queue_free()
		


func _on_jump_pressed():	
	print("hi")
	Input.action_press("ui_up")


func _on_break_pressed():
	
	print("hola")
	Input.action_press("jump")


func _on_break_released():
	Input.action_release("jump")


func _on_jump_released():
	Input.action_release("ui_up")
