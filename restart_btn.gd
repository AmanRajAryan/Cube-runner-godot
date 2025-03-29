extends Button

@onready var player = %player
@onready var game_over_screen = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	player.position = Vector3(0 , 1.6 , 3)
	game_over_screen.visible = false
	game_over_screen.visible = false
