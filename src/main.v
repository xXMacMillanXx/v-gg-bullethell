module main

import gg
import gx
import time
import math

type Collidable = Enemy | Player

[flag]
enum State {
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
	player Player
	enemies []Enemy
	frame_timer time.StopWatch = time.new_stopwatch()
}

fn (mut g Game) update(delta f32) {
	g.player.update(delta)
	for mut enemy in g.enemies {
		enemy.update()
	}
}

fn (mut g Game) draw() {
	g.ctx.begin()
	g.player.draw(g)
	for enemy in g.enemies {
		enemy.draw(g)
	}
	g.ctx.end()
}

fn (mut g Game) frame(_ voidptr) {
	delta := f32(g.frame_timer.elapsed().milliseconds()) / 1000
	g.frame_timer.restart()
	// println(delta)
	g.update(delta)
	g.draw()
	// println(g.ctx.frame)
	for bullet in g.player.bullets {
		for enemy in g.enemies {
			if bullet.is_colliding(enemy) {
				g.enemies.delete(g.enemies.index(enemy))
			}
		}
	}
}

fn (mut g Game) event(eve &gg.Event, _ voidptr) {
	// println("${eve.typ}, ${eve.key_code}, ${eve.char_code}")
	match eve.key_code {
		.up, .w { if eve.typ == .key_down {g.player.state.set(.moving_up)} else if eve.typ == .key_up {g.player.state.clear(.moving_up)} }
		.down, .s { if eve.typ == .key_down {g.player.state.set(.moving_down)} else if eve.typ == .key_up {g.player.state.clear(.moving_down)} }
		.left, .a { if eve.typ == .key_down {g.player.state.set(.moving_left)} else if eve.typ == .key_up {g.player.state.clear(.moving_left)} }
		.right, .d { if eve.typ == .key_down {g.player.state.set(.moving_right)} else if eve.typ == .key_up {g.player.state.clear(.moving_right)} }
		.space, .z, .y { if eve.typ == .key_down {g.player.state.set(.shooting)} else if eve.typ == .key_up {g.player.state.clear(.shooting)} }
		.left_shift, .x { if eve.typ == .key_down {g.player.state.set(.bombing)} else if eve.typ == .key_up {g.player.state.clear(.bombing)} }
		else {}
	}
}

fn main() {
	mut game := &Game{}
	mut player := Player.new(100, 300, 25, 50)
	game.ctx = gg.new_context(
			bg_color: gx.black
			width: 600
			height: 400
			window_title: 'GGShooter'
			frame_fn: game.frame
			event_fn: game.event
		)
	game.player = player
	game.enemies = []Enemy{}
	game.enemies << Enemy.new(200, 100, 25, 25)
	game.ctx.run()
}
