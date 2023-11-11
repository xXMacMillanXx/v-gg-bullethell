module main

struct CollisionBox {
	Position
	Size
}

// is_point_colliding checks if the given Position `p` is inside the CollisionBox
fn (c CollisionBox) is_point_colliding(p Position) bool {
	if p.x >= c.x && p.x <= (c.x + c.w) && p.y >= c.y && p.y <= (c.y + c.h) {
		return true
	}

	return false
}

// is_box_colliding checks if any part of a box at Position `p` with Size `s` is inside the CollisionBox
fn (c CollisionBox) is_box_colliding(p Position, s Size) bool {
	if p.x >= (c.x - s.w) && p.x <= (c.x + c.w) && p.y >= (c.y - s.h) && p.y <= (c.y + c.h) {
		return true
	}

	return false
}

// is_circle_colliding checks if any part of a circle at Position `p` with `radius` is inside the CollisionBox
fn (c CollisionBox) is_circle_colliding(p Position, radius f32) bool {
	mut x := f32(0.0)
	mut y := f32(0.0)
	
	if p.x >= c.x && p.x <= (c.x + c.w) {
		x = p.x
	} else if p.x >= c.x {
		x = c.x + c.w
	} else {
		x = c.x
	}

	if p.y >= c.y && p.y <= (c.y + c.h) {
		y = p.y
	} else if p.y >= c.y {
		y = c.y + c.h
	} else {
		y = c.y
	}
	
	distance := p.distance_to(Position{x, y})
	if distance <= radius {
		return true
	}

	return false
}

fn (mut c CollisionBox) pos_update(p Position) {
	c.x = p.x
	c.y = p.y
}
