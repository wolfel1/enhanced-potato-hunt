extends RigidBody2D

const spritesheet = preload("res://assets/plant/spritesheet.png")
const texture_width = 288/3
const template_message = "You have harvested %d %s!"

func _ready():
	var texture = AtlasTexture.new()
	texture.set_atlas(spritesheet)
	texture.set_region(Rect2(randi_range(0, 2) * texture_width, 0, texture_width, 129))
	$Sprite2D.set_texture(texture)
	$CollisionShape2D.disabled = false
	$PoatoInformation.hide()


func harvest():
	var potato_count = randi_range(0, 6)
	$Sprite2D.hide()
	$AudioStreamPlayer.play()
	$CollisionShape2D.set_deferred("disabled", true)
	show_message(potato_count)
	return potato_count

func show_message(count):
	if count == 0:
		$PoatoInformation.text = "No potato!"
	elif count == 1:
		$PoatoInformation.text = template_message % [count, "potato"]
	else:
		$PoatoInformation.text = template_message % [count, "potatoes"]
	$PoatoInformation.show()
	$ShowMessageTimer.start()

func _on_show_message_timer_timeout():
	$PoatoInformation.hide()
	queue_free()
