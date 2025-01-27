extends Area2D

class_name InteractPromptArea

signal interactable_text_signal(text)

export (String) var interactableText: String = ""
export (NodePath) var playerNodePath

onready var _collisionShape: CollisionShape2D = get_node("CollisionShape")
onready var _f_prompt: Sprite = get_node("FPrompt")
onready var _player: Node = get_node(playerNodePath)

func _ready():
	var path = self.get_path()
	assert(_collisionShape, "Add child node of type CollisionShape2D with name CollisionShape in: " + path)
	assert(_f_prompt, "Add child node of type Sprite with name FPrompt in: " + path)
	assert(_player, "Make sure the player has been added by giving the playerNodePath in the editor in: " + path)
	self.connect("body_entered", self, "_showPrompt")
	self.connect("body_exited", self, "_hidePrompt")


# node to handle player input, and call the proper response
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(EventsList.INTERACT_EVENT) and self.overlaps_body(_player):
		get_tree().set_input_as_handled()
		_emitInteractableText()
		

func _emitInteractableText():
	emit_signal("interactable_text_signal", interactableText)


func _showPrompt(body: Node):
	if body == _player:
		_f_prompt.visible = true


func _hidePrompt(body: Node):
	if body == _player:
		_f_prompt.visible = false
