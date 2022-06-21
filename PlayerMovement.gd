extends KinematicBody2D

export (int) var SPEED = 100
export (int) var GRAVITY = 20
export (int) var JUMP_FORCE = -700
export (float) var ROOM_SIZE = 0.19

var phys_floor = false
var phys_bump = false

var PAUSED = false

var jump_limit = 1

export var max_jumps = 1

export var USE_LIGHTING = false

var velocity = Vector2()

func get_input():
	if (Input.is_action_just_pressed("menu")) and !PAUSED:
		print("menu")
		PAUSED = true
		$blur.visible = true
		$HUD.visible = true
	elif (Input.is_action_just_pressed("menu")) and PAUSED:
		print("menu")
		PAUSED = false
		$blur.visible = false
		$HUD.visible = false
	
	if !PAUSED:
		if Input.is_action_pressed("right"):
			if (Input.is_action_pressed("dash")):
				velocity.x += SPEED + 40
			velocity.x += SPEED
		if Input.is_action_pressed("left"):
			if (Input.is_action_pressed("dash")):
				velocity.x -= SPEED + 40
			velocity.x -= SPEED
		
		if (is_on_wall()):
			if Input.is_action_just_pressed("up") and jump_limit <= max_jumps:
				print(jump_limit)
				velocity.y = JUMP_FORCE + 10
				randomize()
				jump_limit += 1
				$sounds.stream = load("res://sfx/run_steel_" + str(int(rand_range(1, 4))) + ".wav")
					
				$sounds.play()
		if is_on_floor():
			if Input.is_action_pressed("up"):
				velocity.y = JUMP_FORCE
				randomize()
				$sounds.stream = load("res://sfx/Arm Whoosh Quick 0" + str(int(rand_range(1, 3))) + ".wav")
				
				$sounds.play()
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x,0,0.2)

func _process(delta):
	var reverb:AudioEffectReverb = AudioServer.get_bus_effect(AudioServer.get_bus_index("Reverb"), 0)
	
	reverb.room_size = ROOM_SIZE
	
	get_input()
	if (!is_on_floor()): phys_floor = true
	
	if (!is_on_wall() or !is_on_ceiling()): phys_bump = true
	
	
		
	
	if (is_on_floor() and phys_floor):
		print("No override")
		randomize()
		$sounds.stream = load("res://sfx/sfx_hit_grapple0" + str(int(rand_range(1, 4))) + ".wav")
			
		$sounds.play()
		jump_limit = 0
		phys_floor = false
	if (velocity.y > 10000):
		get_tree().reload_current_scene()
		
	
	#if (velocity == Vector2()):
		#print("W")
	
func play_music_bg():
	randomize()
	$ambience.stream = load("res://music/menu0" + str(int(rand_range(1, 2))) + ".mp3")
	
	$ambience.play()
	
func _ready():
	
	play_music_bg()
	
	if USE_LIGHTING:
		$Light2D.visible = true

func ShowDial():
	print("Wait")
	$Camera2D/CanvasLayer/RESET.visible = true
	$player_genans.play("rest")
	#print($Camera2D/RESET)
	
func Win():
	print("Player log: won Level")
	
	get_tree().change_scene("res://ui/Main.tscn")
