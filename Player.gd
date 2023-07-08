extends Area2D

signal collected(count)

@export var speed = 400
var screen_size
var level_size
var size
var is_started : bool = false

func _ready():
	hide()
	screen_size = get_viewport_rect().size
	size = $CollisionShape2D.get_shape().get_rect().size
	
func init(pos, level):
	position = pos
	level_size = level.get_texture().get_size()
	init_camera()
	
func start():
	show()
	$CollisionShape2D.disabled = false
	is_started = true
	
func init_camera():
	var camera = $Camera2D
	camera.set_limit(SIDE_LEFT, 0)
	camera.set_limit(SIDE_TOP, 0)
	camera.set_limit(SIDE_RIGHT, level_size.x)
	camera.set_limit(SIDE_BOTTOM, level_size.y)
	

func _process(delta):
	if is_started:
		move_player(delta)

func move_player(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, size.x/2, level_size.x - size.x/2)
	position.y = clamp(position.y, size.y/2, level_size.y - size.y/2)
	
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "walk_right"
	elif velocity.x < 0:
		$AnimatedSprite2D.animation = "walk_left"
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_back"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_front"
	else:
		$AnimatedSprite2D.animation = "idle_front"


func _on_body_entered(body):
	var potato_count = body.harvest()
	collected.emit(potato_count)


func _on_pause():
	is_started = false


func _on_hud_continued():
	is_started = true

func _on_animated_frame_changed():
	$AnimatedSprite2D/Footstep.play()
