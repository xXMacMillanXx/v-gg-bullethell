module main

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
