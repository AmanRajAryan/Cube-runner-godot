extends Camera3D
@onready var player = $"../../player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#position.z = lerp(position.z ,player.position.z +2 , .1)
	position.z = player.position.z +4
