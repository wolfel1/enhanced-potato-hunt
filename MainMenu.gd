extends CanvasLayer

signal start_game

func _ready():
	$Instructions.hide()

func _on_start_button_pressed():
	$ButtonAudioStreamPlayer.play()
	start_game.emit()


func _on_instructions_button_pressed():
	$ButtonAudioStreamPlayer.play()
	$StartScreen.hide()
	$Instructions.show()

func _on_back_button_pressed():
	$ButtonAudioStreamPlayer.play()
	$StartScreen.show()
	$Instructions.hide()


func _on_quit_button_pressed():
	get_tree().quit()
