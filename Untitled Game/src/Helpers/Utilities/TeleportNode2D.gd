extends Node2D

const _PLAYER_NAME: String = "LirikYaki"
const _interactionTimeout: float = 1.0

var _on_cooldown: bool = false
var _playerBody

func _onready():
	$EndpointAlpha/PromptAlpha.visible = false
	$EndpointBeta/PromptBeta.visible = false
	#here i would use a way to identify the current player body globally, 
	#using the body name and a variable is shitty and should be improved

func _input(event: InputEvent) -> void:
	if event.is_action("interact") && !_on_cooldown:
		_startInteractionTimeout()
		if $EndpointAlpha/PromptAlpha.visible:
			_playerBody.position = $EndpointBeta.get_global_position()
		elif $EndpointBeta/PromptBeta.visible:
			_playerBody.position = $EndpointAlpha.get_global_position()

func _on_EndpointAlpha_body_entered(body):
	if body.name == _PLAYER_NAME:
		_playerBody = body
		$EndpointAlpha/PromptAlpha.visible = true

func _on_EndpointAlpha_body_exited(body):
	if body.name == _PLAYER_NAME:
		$EndpointAlpha/PromptAlpha.visible = false

func _on_EndpointBeta_body_entered(body):	
	if body.name == _PLAYER_NAME:
		_playerBody = body
		$EndpointBeta/PromptBeta.visible = true

func _on_EndpointBeta_body_exited(body):
	if body.name == _PLAYER_NAME:
		$EndpointBeta/PromptBeta.visible = false

func _startInteractionTimeout() -> void:
	if !_on_cooldown:
		_on_cooldown = true
		yield(get_tree().create_timer(_interactionTimeout), "timeout")
		_on_cooldown = false
