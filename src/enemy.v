module main

import gx

struct Enemy {
	Position
	Size
mut:
	direction Vector = Vector{0,0}
	bullets []Projectile = []Projectile{}
	coll CollisionBox
}

fn Enemy.new(x int, y int, w int, h int) Enemy {
	c := CollisionBox{Position{x, y}, Size{w, h}}
	return Enemy{ Position: Position{x, y}, Size: Size{w, h}, coll: c }
}

fn (mut e Enemy) update() {
	e.x += e.direction.x
	e.y += e.direction.y
	e.coll.pos_update(Position{e.x, e.y})
}

fn (e Enemy) draw(g Game) {
	g.ctx.draw_rect_filled(e.x, e.y, e.w, e.h, gx.red)
}
