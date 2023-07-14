extends CanvasLayer

signal start_game
var last_potato_count : int = 0

func _ready():
	$Instructions.hide()
	$Credits.hide()
	$BackButton.hide()

func update_best_time(time : String, potato_count : int):
	if (potato_count >= last_potato_count):
		$BestScoreLabel.text = "%d Potatoes in %s" % [potato_count, time]
	
func _on_start_button_pressed():
	$ButtonAudioStreamPlayer.play()
	start_game.emit()


func _on_instructions_button_pressed():
	$ButtonAudioStreamPlayer.play()
	var start_nodes = get_tree().get_nodes_in_group("Start")
	for node in start_nodes:
		node.hide()
	
	$Instructions.show()
	$BackButton.show()

func _on_back_button_pressed():
	$ButtonAudioStreamPlayer.play()
	var start_nodes = get_tree().get_nodes_in_group("Start")
	for node in start_nodes:
		node.show()
	
	$Instructions.hide()
	$Credits.hide()
	$BackButton.hide()


func _on_quit_button_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_credits_button_pressed():
	$ButtonAudioStreamPlayer.play()
	var start_nodes = get_tree().get_nodes_in_group("Start")
	for node in start_nodes:
		node.hide()
	
	$Credits.show()
	$BackButton.show()
