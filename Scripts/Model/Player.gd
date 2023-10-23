extends ICharacter

@onready var timer = $Timer
var direction

func _physics_process(delta):
	direction = Input.get_axis("left", "right")
	move()
	turn()
	move_and_slide()
	can_dash()
	can_air_jump()

func move():
	if can_move():
		if direction:
			velocity.x = direction * resource.MOVE_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, resource.MOVE_SPEED)

func dash():
	if can_dash():
		resource.IS_DASHING = true
		resource.DASH_LEFT -= 1
		velocity = facing_direction * resource.DASH_SPEED
		await get_tree().create_timer(resource.DASH_DURATION).timeout
		resource.IS_DASHING = false

func jump():
	velocity.y = -resource.JUMP_FORCE

func air_jump():
	if can_air_jump():
		resource.AIR_JUMP_LEFT -= 1
		velocity.y = -resource.JUMP_FORCE

func refill_dash():
	resource.IS_DASH_REFILLING = true
	await get_tree().create_timer(resource.DASH_COOLDOWN).timeout
	resource.IS_DASH_REFILLING = false
	resource.DASH_LEFT = resource.MAX_DASH_COUNT

func refill_air_jump():
	resource.IS_JUMP_REFILLING = true
	await get_tree().create_timer(resource.JUMP_COOLDOWN).timeout
	resource.IS_JUMP_REFILLING = false
	resource.AIR_JUMP_LEFT = resource.MAX_AIR_JUMP_COUNT

func can_dash():
	if !resource.IS_DASHING && resource.DASH_LEFT < resource.MAX_DASH_COUNT && !resource.IS_DASH_REFILLING && (is_on_floor()):
		refill_dash()
	return resource.DASH_LEFT > 0

func can_air_jump():
	if resource.AIR_JUMP_LEFT < resource.MAX_AIR_JUMP_COUNT && !resource.IS_JUMP_REFILLING && (is_on_floor()):
		refill_air_jump()
	return resource.AIR_JUMP_LEFT > 0
	
func can_move():
	return !resource.IS_DASHING
