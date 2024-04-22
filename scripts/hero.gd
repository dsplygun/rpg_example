extends CharacterBody2D

#@onready var anim : AnimationTree = $AnimationTree
@onready var area : Area2D = $InteractingArea
@export var speed : float = 300.0
@export var friction : float = 6000.0

func _ready():
	pass

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left","right","up","down")
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2(move_toward(velocity.x, 0, friction*delta),move_toward(velocity.y, 0, friction*delta))

	move_and_slide()

func _input(event):
	if event is InputEventKey and Input.get_action_strength("interact"):
		for b in area.get_overlapping_bodies():
			if b.has_method("interact"):
				b.interact()
