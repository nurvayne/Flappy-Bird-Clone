extends CharacterBody2D

class_name Birb

signal game_started

@export var gravity = 900.0
@export var flap_force = -300.0
@export var rotation_speed = 2
@export var max_speed = 400.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_started = false
var process_input = true

func _ready() -> void:
	velocity = Vector2.ZERO
	animation_player.play("idle")
	is_started = false
	process_input = true
	
func _physics_process(delta: float) -> void:
	if process_input:
		if Input.is_action_just_pressed("flap"):
			if !is_started:
				is_started = true
				game_started.emit()
				animation_player.play("flap_wings")
			flap()
	
	if !is_started:
		return
	
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, max_speed)
	move_and_collide(velocity * delta)
	rotate_bird()
	

func rotate_bird():
	#rotate downwards when falling
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	#rotate upwards when flapping
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)

func flap():
	velocity.y = flap_force
	rotation = deg_to_rad(-30) 

func kill():
	process_input = false
	
func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
	
	
