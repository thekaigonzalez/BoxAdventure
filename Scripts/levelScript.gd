extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var linked = null

export var unofficial = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_level_pressed():
	
	get_tree().change_scene_to(linked)
		
