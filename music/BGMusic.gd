extends AudioStreamPlayer

var normal_music = preload("res://music/normal-music.wav")
var boss_music = preload("res://music/boss-music.wav")

func _process(_delta):
	# Starts playing music for boss level (level 4)
	if Global.boss_music_playing and Global.new_music_started:
		Global.new_music_started = false
		stream = boss_music
		volume_db = -15.0
		play()
	# Starts playing music for anything but the boss level
	if !Global.boss_music_playing and Global.new_music_started:
		Global.new_music_started = false
		stream = normal_music
		volume_db = -10.0
		play()
