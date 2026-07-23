extends Node2D

@export var Music_Volume_Modifier := 1.0
@export var SFX_Volume_Modifier := 1.0

var current_player :AudioStreamPlayer = null

# Sound Effect Paths
# Add SFX definitions, then play the SFX in other scripts with play_sfx
const CLICK = preload("res://stock/interface-sounds/click_002.ogg")
const LOW_POWER_WARNING = preload("res://audio/universfield-low-power-warning-487889.mp3")


# MUSIC: only one song can play at a time, it will override, Music bus
# SFX: can play simultaneously, SFX bus

# NOTE: VOLUME IS A PERCENTAGE BETWEEN 0 AND 1
func play_sfx(stream : AudioStream, volume : float = 1) -> void:
	var fx :AudioStreamPlayer= AudioStreamPlayer.new()
	fx.stream = stream
	fx.name = "SFX Player"
	fx.bus = "SFX"

	# Use volume linear for it to work with bus
	fx.volume_db = linear_to_db(volume)
	add_child(fx)
	fx.play()
	fx.finished.connect(fx.queue_free)


func play_music(Stream : AudioStream, Volume : float) -> void:
	if current_player:
		if Stream == current_player.stream:
			return
		current_player.queue_free()
	var musicPlayer : AudioStreamPlayer= AudioStreamPlayer.new()
	musicPlayer.stream = Stream
	musicPlayer.name = "Music Player"
	musicPlayer.volume_db = Volume
	musicPlayer.bus = "Music"
	add_child(musicPlayer)
	
	musicPlayer.play()
	current_player = musicPlayer
	musicPlayer.finished.connect(musicPlayer.queue_free)
	
