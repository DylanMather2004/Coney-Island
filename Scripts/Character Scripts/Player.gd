class_name Player
extends Character
@export var jump_height:float
@export var sprint_speed:float
#Friction and Acceleration will be used to determine how quickly the player speeds up and slows down
# 1 is immediate, 0 won't stop the player
@export_range(0,1) var friction:float
@export_range(0,1) var acceleration:float
@export_range(0,1) var sprint_acceleration:float 
@export var gravity:float = 100 
var attack_animator
var jump_buffer=0.2
var current_buffer = 0
var direction = 0
enum move_states{STANDING,WALKING,SPRINTING}
var state=move_states.STANDING
func _ready():
	super._ready()
	attack_animator=$AttackAnimator
	
func _move_input():
	direction = Input.get_axis('left','right')
	
func _input(event):
	if Input.is_action_just_pressed("jump"):
		current_buffer=jump_buffer
	if Input.is_action_just_pressed("punch"):
		match state:
			move_states.STANDING:
				attack_animator.play('Attack 1')
			move_states.WALKING:
				pass

func _process(delta):
	_move_input()
	if current_buffer>0:
		current_buffer-=delta
func _physics_process(delta):
	
	if !is_on_floor():
		velocity.y+=gravity*delta
	else:
		if current_buffer>0:
			velocity.y =-jump_height
	if direction:
		state=move_states.WALKING
		velocity.x=lerpf(0,direction*move_speed,acceleration)
	else:
		state=move_states.STANDING
		velocity.x = lerpf(velocity.x,0,friction)
	move_and_slide()
	
func _on_attackbox_body_entered(body):
	if body.is_in_group('Enemy'):
		body.Change_Health(-damage)
