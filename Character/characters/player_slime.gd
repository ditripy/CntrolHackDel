extends CharacterBody2D
#parameters/Idle/blend_position

#@export var starting_direction : Vector2 = Vector2(0,0.5)
#@onready var animation_tree = $AnimationTree

var animation_speed = 3
var moving = false 


var tile_size = 16
var inputs = {"right": Vector2.RIGHT,
			  "left": Vector2.LEFT,
			   "up": Vector2.UP,
			   "down": Vector2.DOWN}
			
func _ready():
	#update_animation_parameters(starting_direction)
	position = position.snapped(Vector2.ONE * tile_size) #set position to nearest tile
	position += Vector2.ONE * tile_size/2 #offset to make sure character is centered
	
	#movement code to check which key is pressed then that value is passed into the move function
func _unhandled_input(event):
	#var is_moving = false
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

			#update_animation_parameters(inputs[dir])
			
		#if not is_moving:
		#update_animation_parameters(Vector2.ZERO)

@onready var ray = $RayCast2D

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = create_tween()
		tween.tween_property(self,"position",
			position + inputs[dir] * tile_size,0.6/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
	

	
	
#func update_animation_parameters(event : Vector2):
	#if(event != Vector2.ZERO):
		#animation_tree.set("parameters/Walk/blend_position", event)
		#animation_tree.set("parameters/Idle/blend_position", event)	


#@export var move_speed : float = 100

#func _physics_process(_delta):
	#Get input direction
	#var input_direction = Vector2(
		#Input.get_action_strength("right") - Input.get_action_strength("left"),
		#Input.get_action_strength("down") - Input.get_action_strength("up")
	#)
	
	
	# Update Velocity
	#velocity = input_direction * move_speed
	
	#Move and Slide function uses velocity of character body to move character on map
	#move_and_slide()
	
	
	
