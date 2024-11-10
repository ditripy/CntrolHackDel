extends Node2D

var selected = false
var rest_point = Vector2.ZERO
var rest_nodes = []
var move_speed = 25  # Control how fast the object moves

# Called when the node enters the scene tree for the first time.
func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	
	if rest_nodes.size() > 0:
		rest_point = rest_nodes[0].global_position  # Assign rest_point from the first zone node
	else:
		rest_point = global_position  # Fallback to current position if no rest nodes

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true  # This object is selected when clicked

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), move_speed * delta)  # Move to mouse
		look_at(get_global_mouse_position())  # Optional: make the object face the mouse
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)  # Move back to rest_point

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false  # Deselect this object when mouse is released
			var shortest_dist = 75  # The distance to consider for selecting a nearby zone
			for child in rest_nodes:
				if child.has_method("select"):  # Check if it has the select method
					var distance = global_position.distance_to(child.global_position)
					if distance < shortest_dist:
						child.select()  # Select the closest zone
						rest_point = child.global_position  # Update the resting point
						shortest_dist = distance
