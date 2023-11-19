module main

import gg
import gx

struct Button {
	Position
	Size
mut:
	coll CollisionBox
	text string
	on_click_fn fn(mut Game, &gg.Event) = fn(mut g Game, e &gg.Event) { println('button clicked') }
}

fn Button.new(x int, y int, w int, h int, text string) Button {
	c := CollisionBox{Position{x,y}, Size{w,h}}
	return Button{Position: Position{x,y}, Size: Size{w,h}, coll: c, text: text}
}

fn (mut b Button) on_click(action fn(mut Game, &gg.Event)) {
	b.on_click_fn = action
}

fn (mut b Button) update() {

}

fn (b Button) draw(g Game) {
	g.ctx.draw_rect_filled(b.x, b.y, b.w, b.h, gx.white)
	g.ctx.draw_text(int(b.x), int(b.y), b.text, gx.TextCfg{size: 32})
}

fn (mut b Button) event(mut g Game, e &gg.Event) {
	if e.typ == .mouse_down && b.coll.is_point_colliding(Position{e.mouse_x, e.mouse_y}) {
		b.on_click_fn(mut g, e)
	}
}
