extends CanvasLayer

func update_potato_count(potato_count):
	$PotatoLabel.text = str(potato_count)

func update_time(time: int):
	var seconds = time / 1000
	var minutes = seconds / 60
	seconds %= 60
	var milliseconds = time % 1000
	$TimeLabel.text = "%02d:%02d:%03d" % [minutes, seconds, milliseconds]
	
