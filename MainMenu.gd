extends CanvasLayer

signal start_game

func _ready():
	$InstructionText.hide()
	$BackButton.hide()

func _on_start_button_pressed():
	start_game.emit()


func _on_instructions_button_pressed():
	$StartButton.hide()
	$InstructionsButton.hide()
	$InstructionText.show()
	$BackButton.show()



func _on_back_button_pressed():
	$StartButton.show()
	$InstructionsButton.show()
	$InstructionText.hide()
	$BackButton.hide()
