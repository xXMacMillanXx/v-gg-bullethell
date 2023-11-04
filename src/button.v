module main

import gg
import gx

struct Button {
	Position
	Size
mut:
	coll CollisionBox
	on_click_fn fn() = fn() { println('button clicked') }
}

fn Button.new(x int, y int, w int, h int) Button {
	c := CollisionBox{Position{x,y}, Size{w,h}}
	return Button{Position: Position{x,y}, Size: Size{w,h}, coll: c}
}

fn (mut b Button) on_click(action fn()) {
	b.on_click_fn = action
}

fn (mut b Button) update() {

}

fn (b Button) draw(g Game) {
	g.ctx.draw_rect_filled(b.x, b.y, b.w, b.h, gx.white)
}

fn (mut b Button) event(mut g Game, e &gg.Event) {
	if e.typ == .mouse_down && b.coll.is_point_colliding(Position{e.mouse_x, e.mouse_y}) {
		//b.on_click_fn()
		// Not very happy with this, but couldn't get on_click to work without invalid memory access :/
		g.states.change_state(.game)
	}
}
