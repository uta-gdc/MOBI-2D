extends Node2D

const red_barrier: Resource = preload('res://assets/red_barrier.png')
const blue_barrier: Resource = preload('res://assets/blue_barrier.png')
const green_barrier: Resource = preload('res://assets/green_barrier.png')
const yellow_barrier: Resource = preload('res://assets/yellow_barrier.png')

var barrier_0: StaticBody2D
var barrier_1: StaticBody2D
var barrier_2: StaticBody2D
var barrier_3: StaticBody2D


func _ready() -> void:
    barrier_0 = $'Barrier0'
    barrier_1 = $'Barrier1'
    barrier_2 = $'Barrier2'
    barrier_3 = $'Barrier3'
    
    barrier_0.get_node('Sprite2D').set_texture(red_barrier)
    barrier_0.get_node('Sprite2D').set_position(Vector2i(8, 40))
    
    barrier_1.get_node('Sprite2D').set_texture(blue_barrier)
    barrier_1.get_node('Sprite2D').set_position(Vector2i(8, 40))
    
    barrier_2.get_node('Sprite2D').set_texture(green_barrier)
    barrier_2.get_node('Sprite2D').set_position(Vector2i(8, 40))
    
    barrier_3.get_node('Sprite2D').set_texture(yellow_barrier)
    barrier_3.get_node('Sprite2D').set_position(Vector2i(8, 40))
    return
