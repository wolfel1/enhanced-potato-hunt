extends CanvasLayer

signal start_game

func _ready():
	$Instructions.hide()

func _on_start_button_pressed():
	start_game.emit()


func _on_instructions_button_pressed():
	$StartButton.hide()
	$InstructionsButton.hide()
	$Instructions.show()

func _on_back_button_pressed():
	$StartButton.show()
	$InstructionsButton.show()
	$Instructions.hide()
