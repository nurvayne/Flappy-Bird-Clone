extends Node2D

class_name Ground

signal birb_crashed

@export var speed = -150.0
@onready var sprite1: Sprite2D = $Ground1/Sprite2D
@onready var sprite2: Sprite2D = $Ground2/Sprite2D

func _ready():
	sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()	

func _process(delta: float) -> void:
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta
	
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite2.texture.get_width()
	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()


func _on_body_entered(body: Node2D) -> void:
	birb_crashed.emit()
	stop()
	(body as Birb).stop()
	#if body.name == "Birb":
		#lose()
	
#func lose():
	#get_tree().reload_current_scene()
	
func stop():
	speed = 0
	
