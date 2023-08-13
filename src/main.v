module main

import gg
import gx

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
}

struct Player {
	Position
	Size
mut:
	direction Vector
	bombs int = 3
}

struct Game {
mut:
	ctx gg.Context
	player Player
}

fn (mut g Game) update() {
	g.player.x += g.player.direction.x
	g.player.y += g.player.direction.y
}

fn (mut g Game) draw() {
	g.ctx.begin()
	g.ctx.draw_rect_filled(g.player.x, g.player.y, g.player.w, g.player.h, gx.white)
	g.ctx.end()
}

fn (mut g Game) frame(_ voidptr) {
	g.update()
	g.draw()
}

fn (mut g Game) event(eve &gg.Event, _ voidptr) {
	println("${eve.typ}, ${eve.key_code}, ${eve.char_code}")
	match eve.key_code {
		.up, .w { if eve.typ == .key_down {g.player.direction.y = -10} else if eve.typ == .key_up {g.player.direction.y = 0} }
		.down, .s { if eve.typ == .key_down {g.player.direction.y = 10} else if eve.typ == .key_up {g.player.direction.y = 0} }
		.left, .a { if eve.typ == .key_down {g.player.direction.x = -10} else if eve.typ == .key_up {g.player.direction.x = 0} }
		.right, .d { if eve.typ == .key_down {g.player.direction.x = 10} else if eve.typ == .key_up {g.player.direction.x = 0} }
		else {}
	}
}

fn main() {
	mut game := &Game{}
	mut player := Player { Position {100, 100}, Size {25, 50}, Vector {0, 0}, 3 }
	println(player)
	game.ctx = gg.new_context(
			bg_color: gx.black
			width: 600
			height: 400
			window_title: 'GGShooter'
			frame_fn: game.frame
			event_fn: game.event
		)
	game.player = player
	game.ctx.run()
}
