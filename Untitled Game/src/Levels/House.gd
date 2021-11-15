extends Node2D

#onready var _camera = $Camera2D
var _player : Actor

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = Globals.GetPlayerActor() #ugh
	_player.connect("health_changed", self, "_on_Player_health_changed")
	_on_Player_health_changed(_player._health, _player._health, _player._maxHealth)

func _on_Player_health_changed(_oldHealth, newHealth, maxHealth):
	var healthBar = get_node("GUI/Control/healthBar")
	healthBar.Health = newHealth
	healthBar.MaxHealth = maxHealth
	healthBar.update_health()
