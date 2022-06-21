extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func listDir(d):
	var dir = Directory.new()
	
	dir.open(d)
	
	var l = []
	
	dir.list_dir_begin()
	
	while true:
		var f = dir.get_next()
		if (f == ""): break
		elif not f.begins_with("."):
			l.append(f)
		
	dir.list_dir_end()
	
	return l


# Called when the node enters the scene tree for the first time.
func _ready():
	for dir in listDir("user://gamemodes"):
		var name = dir.get_basename()
		ProjectSettings.load_resource_pack("user://gamemodes/" + dir)
		
		var levelinstance = load("res://Comp/Level.tscn").instance()
		
		levelinstance.linked = load("res://Levels/" + name + ".tscn")
		levelinstance.text = name
		
		levelinstance.unofficial = true
		
		levelinstance.align = Button.ALIGN_LEFT
		$levles.add_child(levelinstance)
