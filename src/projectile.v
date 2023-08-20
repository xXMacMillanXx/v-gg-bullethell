module main

import gx

struct Projectile {
	Position
	Size
mut:
	direction Vector
}

fn (mut p Projectile) update() {
	p.x += p.direction.x
	p.y += p.direction.y
}

fn (p Projectile) draw(g Game) {
	g.ctx.draw_rect_filled(p.x, p.y, p.w, p.h, gx.yellow)
}

fn (p Projectile) is_colliding(c Collidable) bool {
	return c.coll.is_box_colliding(p.Position, p.Size)
}
