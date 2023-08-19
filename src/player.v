module main

import gx

struct Player {
	Position
	Size
mut:
	direction Vector
	speed int = 50
	bullets []Projectile
	bomb_count int = 3
	bombs []Bomb
	state State
}

fn (mut p Player) update(delta f32) {
	p.x += p.direction.x * delta
	p.y += p.direction.y * delta

	if p.state.has(.bombing) {
		if p.bomb_count > 0 {
			p.bomb_count--
			p.bombs << Bomb{Position{p.x, p.y}, 0.0}
		}
	}
	for mut bomb in p.bombs {
		bomb.update()
	}

	if p.state.has(.shooting) {
		p.bullets << Projectile{ Position{p.x, p.y}, Size{10, 10}, Vector{0, -5} }
	}
	for mut bullet in p.bullets {
		bullet.update()
	}
}

fn (p Player) draw(g Game) {
	g.ctx.draw_rect_filled(p.x, p.y, p.w, p.h, gx.white)
	
	for bomb in p.bombs {
		bomb.draw(g)
	}
	
	for bullet in p.bullets {
		bullet.draw(g)
	}
}
