extends CanvasLayer

@export_file("*json") var scene_text_file: String

var sceneText: Dictionary = {}
var selectedText: Array = []
var in_progress: bool = false

@onready var background = $Background
@onready var textLabel = $TextLabel

func _ready():
	background.visible = false
	sceneText = load_text()
	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))

func load_text():
	if FileAccess.file_exists(scene_text_file): # if the file exist then
		var file = FileAccess.open(scene_text_file, FileAccess.READ) # make file = the scene_text_file
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()

func show_text():
	textLabel.text = selectedText.pop_front()

func next_line():
	if selectedText.size() > 0:
		show_text()
	else:
		finish()

func finish():
	textLabel.text = ""
	background.visible = false
	in_progress = false
	get_tree().paused = false
	
func on_display_dialog(text_key):
	if in_progress:
		print("AKLSJDKLASJd")
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		selectedText = sceneText[text_key].duplicate()
		show_text()
