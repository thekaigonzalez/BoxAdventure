extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("TitleAnim")
	
	$AnimationPlayer2.play("buttons")


func _on_dlcs_pressed():
	get_tree().change_scene("res://ui/LevelMenu.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("res://ui/Credits.tscn")
