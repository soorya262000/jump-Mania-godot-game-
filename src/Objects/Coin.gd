class_name Coin
extends Area2D
# Collectible that disappears when the player touches it.

onready var animation_player = $AnimationPlayer

# The Coins only detects collisions with the Player thanks to its collision mask.
# This prevents other characters such as enemies from picking up coins.
var attracted=false
var magnetarea
var speed=10
# When the player collides with a coin, the coin plays its 'picked' animation.
# The animation takes cares of making the coin disappear, but also deactivates its
# collisions and frees it from memory, saving us from writing more complex code.
# Click the AnimationPlayer node to see the animation timeline.
func _physics_process(delta):
	if attracted==true:
		movecoin(delta)
		
func movecoin(delta):
	#print("called")
	if(Globals.isalive):
		var direction=(self.global_position-magnetarea.global_position)
		self.position-=direction*speed*delta
	else:
		attracted=false	
func _on_body_entered(_body):
	
	if(_body.name=="Player"):
		if(Globals.soundonoff==1):
			$Pickup.play()
		Globals.coins=Globals.coins+1
		animation_player.play("picked")


func _on_Coin_area_entered(area):
	if(area.name=='coinmagnet'):
		magnetarea=area.get_parent()
		attracted=true
