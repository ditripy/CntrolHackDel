extends Node2D


func _ready():
	SignalBus.connect("update_dialog1", Callable(self, "updateDialog1"))
		
		
		
func updateDialog1(text_key):
	pass
	
