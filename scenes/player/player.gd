extends CharacterBody2D

const JUMP_FORCE: int = -160
const JUMP_RELEASE_FORCE: int = -70
const MAX_SPEED: int = 75
const ACCELERATION: int = 600
const FRICION: int = 600
const GRAVITY: int = 300
const ADDITIONAL_FALL_GRAVITY: int = 120

var player_sprite: Sprite2D
var jump_buffer_timer: Timer
var coyote_jump_timer: Timer

var buffered_jump: bool
var coyote_jump: bool
var on_door: bool


func _ready() -> void:
    player_sprite = $'Sprite2D'
    jump_buffer_timer = $'JumpBufferTimer'
    coyote_jump_timer = $'CoyoteJumpTimer'

    buffered_jump = false
    coyote_jump = false
    on_door = false
    return


func _physics_process(delta: float) -> void:
    var input: Vector2 = Vector2.ZERO
    input.x = Input.get_axis('player_left', 'player_right')

    move_state(input, delta)
    return


func move_state(input: Vector2, delta: float) -> void:
    apply_gravity(delta)

    if not horizontal_move(input):
        apply_friction(delta)
        # animatedSprite.animation = "Idle"
    else:
        apply_acceleration(input.x, delta)
        # animatedSprite.animation = "Run"
        player_sprite.set_flip_h(true if input.x > 0 else false)

    # if not is_on_floor():
        # animatedSprite.animation = "Jump"

    if can_jump():
        input_jump()
    else:
        input_jump_release()
        buffer_jump()
        fast_fall(delta)

    var was_in_air: bool = not is_on_floor()
    var was_on_floor: bool = is_on_floor()

    move_and_slide()

    var just_landed: bool = true if is_on_floor() and was_in_air else false

    # if just_landed:
        # animatedSprite.animation = "Run"
        # animatedSprite.frame = 1

    var just_left_ground: bool = true if not is_on_floor() and was_on_floor else false

    if just_left_ground and velocity.y >= 0:
        coyote_jump = true
        coyote_jump_timer.start()
    return


func input_jump_release() -> void:
    if Input.is_action_just_released('player_jump') and velocity.y < JUMP_RELEASE_FORCE:
        velocity.y = JUMP_RELEASE_FORCE
    return


func buffer_jump() -> void:
    if Input.is_action_just_pressed('player_jump'):
        buffered_jump = true
        jump_buffer_timer.start()
    return


func fast_fall(delta: float) -> void:
    if velocity.y > 0:
        velocity.y += ADDITIONAL_FALL_GRAVITY * delta
    return


func can_jump() -> bool:
    return true if is_on_floor() or coyote_jump else false


func horizontal_move(input: Vector2) -> bool:
    return true if input.x != 0 else false


func input_jump() -> void:
    if on_door:
        return

    if Input.is_action_just_pressed('player_jump') or buffered_jump:
        # SoundPlayer.play_sound(SoundPlayer.JUMP)
        velocity.y = JUMP_FORCE
        buffered_jump = false
    return


func apply_gravity(delta: float) -> void:
    velocity.y = min(velocity.y + GRAVITY * delta, GRAVITY)
    return


func apply_friction(delta: float) -> void:
    velocity.x = move_toward(velocity.x, 0, FRICION * delta)
    return


func apply_acceleration(amount: float, delta: float) -> void:
    velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION * delta)
    return


func __on_jump_buffer_timer_timeout() -> void:
    buffered_jump = false
    return


func __on_coyote_jump_timer_timeout() -> void:
    coyote_jump = false
    return
