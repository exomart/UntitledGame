extends Node

var _cameraManager: CustomCamera2D

func _ready():		
	_cameraManager = CustomCamera2D.new(Globals.GetPlayerActor(), true)

func CameraTransitionToDelimiter(delimiter: CustomDelimiter2D) -> void:
	_cameraManager.limitCameraToDelimiter(delimiter) 

func TeleportPlayerToPosition(position: Vector2) -> void:
	_cameraManager._animationPlayer.playFadeIn()
	yield(_cameraManager._animationPlayer._player, "animation_finished")
	Globals.GetPlayerActor().position = position
	_cameraManager._animationPlayer.playFadeOut()
	
