extends CharacterBody3D



# Minimum swipe distance to detect a swipe (in pixels)
@export var swipe_threshold = 50

@onready var game_over_screen = $"../GameOverScreen"

# Variables to track touch/click input
var swipe_start_position = Vector2()
var is_swiping = false



func _ready():
	pass

func _input(event):
	# Detect touch/mouse press to start a potential swipe
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			# Swipe begins
			is_swiping = true
			swipe_start_position = get_viewport().get_mouse_position()
		elif is_swiping:
			# Swipe ends, check if it was a valid swipe
			is_swiping = false
			_check_swipe(get_viewport().get_mouse_position())
	
	# Track dragging for mouse input
		if event is InputEventMouseMotion and is_swiping:
			_check_swipe(get_viewport().get_mouse_position())

func _check_swipe(current_position):
	# Calculate swipe vector
	var swipe_vector = current_position - swipe_start_position
	
	# Check if the swipe meets the minimum distance threshold
	if swipe_vector.length() < swipe_threshold:
		return
	
	# Determine swipe direction based on the dominant axis
	if abs(swipe_vector.x) > abs(swipe_vector.y):
		# Horizontal swipe
		if swipe_vector.x > 0:
			_on_swipe_right()
		else:
			_on_swipe_left()
	else:
		# Vertical swipe
		if swipe_vector.y < 0:
			_on_swipe_up()
		# You can add down swipe detection here if needed
		# else:
		#     _on_swipe_down()
	
	# Reset swipe tracking
	is_swiping = false

func _on_swipe_left():
	print("Swiped Left")
	if position.x >=0:
		position.x -= 2
	# Add your left swipe logic here

func _on_swipe_right():
	print("Swiped Right")
	if position.x <=0:
		position.x = lerp(position.x , position.x + 20 , 0.1)
	# Add your right swipe logic here

func _on_swipe_up():
	print("Swiped Up")
	if is_on_floor():
		position.y +=2
	# Add your up swipe logic here

# Uncomment if you want to detect down swipes
# func _on_swipe_down():
#     print("Swiped Down")
#     # Add your down swipe logic here




func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity.z =-3
	else :
		velocity.z = -5
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if get_slide_collision_count() > 0:
		var collider =  get_slide_collision(0).get_collider()
		if collider and collider.is_in_group("enemy"):
			game_over_screen.visible = true

	move_and_slide()
