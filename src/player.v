module main

import gx

struct Player {
	Position
	Size
mut:
	direction Vector = Vector{0,0}
	bullets []Projectile = []Projectile{}
	bombs []Bomb = []Bomb{}
	state State = State.idle
	speed int = 300
	bomb_count int = 3
	bomb_cd f32 = 5.0
	bomb_cd_count f32 = 5.0
	atk_speed f32 = 2.0
	atk_count f32 = 2.0
}

fn (mut p Player) update(delta f32) {
	p.x += p.direction.x * delta
	p.y += p.direction.y * delta

	p.bomb_cd_count += delta
	if p.state.has(.bombing) && p.bomb_cd_count >= p.bomb_cd {
		if p.bomb_count > 0 {
			p.bomb_cd_count = 0.0
			p.bomb_count--
			p.bombs << Bomb{Position: Position{p.x, p.y}}
		}
	}
	for mut bomb in p.bombs {
		bomb.update()
	}

	p.atk_count += delta
	if p.state.has(.shooting) && p.atk_count >= (1 / p.atk_speed) {
		p.atk_count = 0.0
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
