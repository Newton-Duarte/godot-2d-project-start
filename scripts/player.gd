extends CharacterBody2D

signal health_depleted

@onready var happy_boo = %HappyBoo
@onready var hurt_box = %HurtBox
@onready var health_bar = %HealthBar

const SPEED := 600
const DAMAGE_RATE := 5.0

@export var health := 100.0

func _ready():
	health_bar.max_value = health

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()
	
	if velocity.length() > 0.0:
		happy_boo.play_walk_animation()
	else:
		happy_boo.play_idle_animation()
	
	
	var overlapping_mobs = hurt_box.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		health_bar.value = health
		if health <= 0.0:
			health_depleted.emit()
