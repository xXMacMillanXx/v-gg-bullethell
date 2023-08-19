module main

import gg
import gx

[flag]
enum State {
	idle
	shooting
	bombing
}

struct Position {
mut:
	x int
	y int
	// z int
}

struct Vector {
mut:
	x int
	y int
	// z int
}

struct Size {
	w int
	h int
	// d int
}

struct Game {
mut:
	ctx gg.Context
	player Player
	enemies []Enemy
}

fn (mut g Game) update() {
	g.player.update()
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
	g.update()
	g.draw()
}

fn (mut g Game) event(eve &gg.Event, _ voidptr) {
	println("${eve.typ}, ${eve.key_code}, ${eve.char_code}")
	match eve.key_code {
		.up, .w { if eve.typ == .key_down {g.player.direction.y = - g.player.speed} else if eve.typ == .key_up {g.player.direction.y = 0} }
		.down, .s { if eve.typ == .key_down {g.player.direction.y = g.player.speed} else if eve.typ == .key_up {g.player.direction.y = 0} }
		.left, .a { if eve.typ == .key_down {g.player.direction.x = - g.player.speed} else if eve.typ == .key_up {g.player.direction.x = 0} }
		.right, .d { if eve.typ == .key_down {g.player.direction.x = g.player.speed} else if eve.typ == .key_up {g.player.direction.x = 0} }
		.space, .z, .y { if eve.typ == .key_down {g.player.state.set(.shooting)} else if eve.typ == .key_up {g.player.state.clear(.shooting)} }
		.left_shift, .x { if eve.typ == .key_down {g.player.state.set(.bombing)} else if eve.typ == .key_up {g.player.state.clear(.bombing)} }
		else {}
	}
}

fn main() {
	mut game := &Game{}
	mut player := Player { Position {100, 300}, Size {25, 50}, Vector {0, 0}, 2, []Projectile{}, 3, []Bomb{}, State.idle }
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
	game.enemies << Enemy{ Position{200, 100}, Size{25, 25}, Vector{0, 0}, []Projectile{} }
	println(game.enemies)
	game.ctx.run()
}
