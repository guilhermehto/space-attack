extends KinematicBody2D

const SPEED = 500

export(PackedScene) var projectile

onready var sprite = $Sprite
onready var timer = $Timer


var screen_size
var half_sprite_size
var can_shoot = true


func _ready():
	screen_size = get_viewport_rect().size.x
	half_sprite_size = sprite.texture.get_width() * scale.x / 2

func _process(delta):
	if Input.is_action_pressed("left"):
		position.x -= SPEED * delta
	elif Input.is_action_pressed("right"):
		position.x += SPEED * delta
	
	if can_shoot and Input.is_action_pressed("shoot"):
		can_shoot = false
		var new_projectile = projectile.instance()
		get_parent().add_child(new_projectile)
		new_projectile.position = position
		timer.start()
	
	position.x = clamp(position.x, 0 + half_sprite_size, screen_size - half_sprite_size)

func _on_Timer_timeout():
	can_shoot = true
