extends TileMapLayer

@onready var tile_map_layer  = $townHallRoof
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame  # Wait for one frame
	if tile_map_layer == null:
		print("Error: 'townHallRoof' node not found after one frame.")
	else:
		print($townHallRoofe)
		SignalBus.connect("roof_vis", Callable(self, "on_roof_vis"))
		
	
	
func on_roof_vis(text_key):
	print("ASDASD")
	tile_map_layer.visible = !tile_map_layer.visible
