extends CanvasLayer

signal continued
signal quit

func _ready():
	$PauseBackground.hide()
	
func update_potato_count(potato_count):
	$PotatoLabel.text = str(potato_count)

func update_time(time: int):
	var seconds = time / 1000
	var minutes = seconds / 60
	seconds %= 60
	var milliseconds = time % 1000
	$TimeLabel.text = "%02d:%02d:%03d" % [minutes, seconds, milliseconds]
	


func _on_pause():
	$PauseBackground.show()


func _on_continue_button_pressed():
	$PauseBackground/AudioStreamPlayer.play()
	continued.emit()
	$PauseBackground.hide()

func _on_quit_button_pressed():
	$PauseBackground.hide()
	quit.emit()
