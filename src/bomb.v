module main

import gx

struct Bomb {
	Position
mut:
	radius f32 = 0.0
	despawn_size f32 = 400.0
	is_stoppable bool
}

fn (mut b Bomb) update() {
	b.radius += 5
	if b.radius >= b.despawn_size {
		b.is_stoppable = true
	}
}

fn (b Bomb) draw(g Game) {
	g.ctx.draw_circle_empty(b.x, b.y, b.radius, gx.yellow)
}

fn (b Bomb) is_colliding(c Collidable) bool {
	return c.coll.is_circle_colliding(b.Position, b.radius)
}
