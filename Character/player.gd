extends CharacterBody2D

class_name Player

@export var speed = 200.0

enum State { IDLE, WALK, SWING }
var state = State.IDLE
var last_direction = "down"

@onready var anim_player = $AnimationPlayer

func _physics_process(delta: float) -> void:
	match state:
		State.SWING:
			velocity = Vector2.ZERO
		_:
			var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			if input_dir != Vector2.ZERO:
				velocity = input_dir.normalized() * speed
				update_last_direction(input_dir)
				if state != State.SWING:
					state = State.WALK
					play_animation("walk_" + last_direction)
			else:
				velocity = Vector2.ZERO
				if state != State.SWING:
					state = State.IDLE
					play_animation("idle_" + last_direction)

			if Input.is_action_just_pressed("swing"):
				start_swing()

	move_and_slide()

func update_last_direction(dir: Vector2) -> void:
	if abs(dir.x) > abs(dir.y):
		last_direction = "right" if dir.x > 0 else "left"
	else:
		last_direction = "down" if dir.y > 0 else "up"

func play_animation(anim_name: String) -> void:
	if anim_player.current_animation != anim_name:
		anim_player.play(anim_name)
		
func start_swing() -> void:
	state = State.SWING
	var swing_anim = "swing_" + last_direction
	anim_player.play(swing_anim)

	await anim_player.animation_finished
	state = State.IDLE
	anim_player.play("idle_" + last_direction)
	
func _ready():
	print("Player scene is active!")
	
