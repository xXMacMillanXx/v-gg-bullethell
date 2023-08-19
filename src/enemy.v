module main

import gx

struct Enemy {
	Position
	Size
mut:
	direction Vector = Vector{0,0}
	bullets []Projectile = []Projectile{}
}

fn (mut e Enemy) update() {
	e.x += e.direction.x
	e.y += e.direction.y
}

fn (e Enemy) draw(g Game) {
	g.ctx.draw_rect_filled(e.x, e.y, e.w, e.h, gx.red)
}
