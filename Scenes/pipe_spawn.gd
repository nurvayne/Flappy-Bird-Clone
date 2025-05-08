extends Node

class_name PipeSpawn

signal birb_crashed
signal point_scored

var pipe_pair_scene = preload("res://Scenes/pipe_pair.tscn")

@export var pipe_speed = -150

@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	spawn_timer.start()

func start_timer():
	spawn_timer.timeout.connect(spawn_pipe)

func spawn_pipe():
	var pipe = pipe_pair_scene.instantiate() as PipePair
	add_child(pipe)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	pipe.position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	pipe.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height,viewport_rect.size.y * 0.65 - half_height)
	
	pipe.birb_entered.connect(on_body_entered)
	pipe.point_scored.connect(on_point_scored)
	pipe.set_speed(pipe_speed)

func on_body_entered():
	birb_crashed.emit()
	stop()

func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is PipePair):
		(pipe as PipePair).speed = 0

func on_point_scored():
	point_scored.emit()
