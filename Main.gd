extends Node

signal pause

@export var plant_scene: PackedScene
var potato_count : int
var start_time : int
var plant_count : int = 0
var is_started : bool = false

func _ready():
	$Player.init($StartPosition.position, $LevelArea)
	
func new_game():
	$MainMenu.hide()
	get_tree().call_group("plants", "queue_free")
	spawn_plants()
	potato_count = 0
	$HUD.update_potato_count(potato_count)
	$Player.start()
	start_time = Time.get_ticks_msec()
	is_started = true

func spawn_plants():
	for i in range(0, 10):
		spawn_plant()
	$PlantSpawnTimer.start()

func spawn_plant():
	var acre = $Acre
	var acre_rect = $Acre/CollisionShape2D.get_shape().get_rect()
	var size = acre_rect.size
	
	var plant = plant_scene.instantiate()
		
	var position = acre.position + Vector2(randf_range(0, size.x), randf_range(0, size.y))
	plant.position = position
		
	add_child(plant)
	plant_count += 1
	

func _process(_delta):
	if is_started:
		var time = Time.get_ticks_msec() - start_time
		$HUD.update_time(time)
		
func _input(event):
	if event.is_action_pressed("pause"):
		is_started = false
		$PlantSpawnTimer.stop()
		pause.emit()
	
	
func _on_plant_collected(count):
	potato_count += count
	$HUD.update_potato_count(potato_count)
	plant_count -= 1

func _on_plant_spawn_timer_timeout():
	if plant_count < 10:
		spawn_plant()


func _on_continued():
	is_started = true
	$PlantSpawnTimer.start()
