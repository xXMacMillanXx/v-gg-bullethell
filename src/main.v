module main

import gg
import gx
import time
import math

type Collidable = Enemy | Player

[flag]
enum EntityState {
	idle
	shooting
	bombing
	moving_up
	moving_left
	moving_down
	moving_right
}

struct Position {
mut:
	x f32
	y f32
	// z f32
}

fn (p Position) distance_to(p2 Position) f32 {
	x := math.abs(p.x - p2.x)
	y := math.abs(p.y - p2.y)
	return math.sqrtf(math.powf(x, 2) + math.powf(y, 2))
}

struct Vector {
mut:
	x f32
	y f32
	// z f32
}

struct Size {
	w f32
	h f32
	// d f32
}

struct Game {
mut:
	ctx gg.Context
	states StateMachine
	frame_timer time.StopWatch = time.new_stopwatch()
}

fn (mut g Game) update(delta f32) {
	g.states.current.update(mut g, delta)
}

fn (mut g Game) draw() {
	g.states.current.draw(mut g)
}

fn (mut g Game) frame(_ voidptr) {
	delta := f32(g.frame_timer.elapsed().milliseconds()) / 1000
	g.frame_timer.restart()
	// println(delta)
	g.update(delta)
	g.draw()
	// println(g.ctx.frame)
}

fn (mut g Game) event(e &gg.Event, _ voidptr) {
	// println("${e.typ}, ${e.key_code}, ${e.char_code}")
	g.states.current.event(mut g, e)
	// global exit event
	if e.typ == .key_down && e.key_code == .escape {
		g.states.current.exit(mut g)
	}
}

fn main() {
	mut game := &Game{ states: StateMachine.new() }
	game.ctx = gg.new_context(
			bg_color: gx.black
			width: 600
			height: 400
			window_title: 'GGShooter'
			frame_fn: game.frame
			event_fn: game.event
		)
	game.ctx.run()
}
