extends CanvasLayer

#emitted when start button pressed
signal start_game

#update score
func update_score(score):
	$ScoreLabel.text = str(score)
	
#displaying get ready and game over
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	#starting timer
	$MessageTimer.start()

#showing game over message
func show_game_over():
	show_message("Game Over")
	await($MessageTimer.timeout)
	$MessageLabel.text = "Dodge the Creeps"
	$MessageLabel.show()
	await get_tree().create_timer(1).timeout
	$Button.show()

func _on_button_pressed():
	$Button.hide()
	emit_signal("start_game")

#hiding message
func _on_message_timer_timeout():
	$MessageLabel.hide()
