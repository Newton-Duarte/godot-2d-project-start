extends CharacterBody2D

@onready var player = $/root/Game/Player
@onready var slime = %Slime

const SPEED := 300

var health = 3

func _ready():
	slime.play_walk()

func _physics_process(delta):
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		move_and_slide()

func take_damage():
	health -= 1
	slime.play_hurt()
	
	if health <= 0:
		queue_free()
		
		const SMOKE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var new_smoke = SMOKE.instantiate()
		get_parent().add_child(new_smoke)
		new_smoke.global_position = global_position
