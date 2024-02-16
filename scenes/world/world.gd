extends Node2D

const red_hammer: Resource = preload('res://assets/hammers/red_hammer.png')
const blue_hammer: Resource = preload('res://assets/hammers/blue_hammer.png')
const green_hammer: Resource = preload('res://assets/hammers/green_hammer.png')
const yellow_hammer: Resource = preload('res://assets/hammers/yellow_hammer.png')
const hammers: Array[Resource] = [red_hammer, blue_hammer, green_hammer, yellow_hammer]

var player: CharacterBody2D
var current_hammer: int


func __change_hammer() -> void:
    var random_hammer: int = randi() % 4
    
    while random_hammer == current_hammer:
        random_hammer = randi() % 4
    
    current_hammer = random_hammer
    player.get_node('Hammer/Sprite2D').set_texture(hammers[random_hammer])
    return


func _ready() -> void:
    randomize()
    player = $'Player'
    __change_hammer()    
    return


func __on_hammer_timer_timeout() -> void:
    __change_hammer()
    return
