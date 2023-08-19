module main

import gx

struct Bomb {
	Position
mut:
	radius f32
}

// needs delta for controlled bombing? bombing cooldown
fn (mut b Bomb) update() {
	b.radius += 2
}

fn (b Bomb) draw(g Game) {
	g.ctx.draw_circle_empty(b.x, b.y, b.radius, gx.yellow)
}
