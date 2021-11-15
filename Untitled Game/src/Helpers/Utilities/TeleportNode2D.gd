extends Node2D

const _interactionTimeout: float = 1.0

var _on_alpha: bool = false
var _on_beta: bool = false
var _on_cooldown: bool = false

func _onready():
	$EndpointAlpha/PromptAlpha.visible = false
	$EndpointBeta/PromptBeta.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action("interact") && !_on_cooldown:
		_startInteractionTimeout()
		if _on_alpha:
			#print("move to beta")
			TransitionsManager.TeleportPlayerToPosition($EndpointBeta/TargetBeta.get_global_position())
		elif _on_beta:
			#print("move to alpha")
			TransitionsManager.TeleportPlayerToPosition($EndpointAlpha/TargetAlpha.get_global_position())

func _on_EndpointAlpha_body_entered(body):
	if body == Globals.GetPlayerActor():
		$EndpointAlpha/PromptAlpha.visible = true
		_on_alpha = true

func _on_EndpointAlpha_body_exited(body):
	if body == Globals.GetPlayerActor():
		$EndpointAlpha/PromptAlpha.visible = false
		_on_alpha = false

func _on_EndpointBeta_body_entered(body):
	if body == Globals.GetPlayerActor():
		$EndpointBeta/PromptBeta.visible = true
		_on_beta = true

func _on_EndpointBeta_body_exited(body):
	if body == Globals.GetPlayerActor():
		$EndpointBeta/PromptBeta.visible = false
		_on_beta = false

func _startInteractionTimeout() -> void:
	if !_on_cooldown:
		_on_cooldown = true
		yield(get_tree().create_timer(_interactionTimeout), "timeout")
		_on_cooldown = false
