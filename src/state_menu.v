module main

import gg

struct MenuState {
mut:
	sm &StateMachine
	btn_start Button
}

fn MenuState.new(sm &StateMachine) MenuState {
	mut b := Button.new(100, 100, 100, 50)
	action := fn (mut g Game, e &gg.Event) {
		g.states.change_state(.game)
	}
	b.on_click(action)
	return MenuState{ sm, b }
}

fn (mut s MenuState) update(mut g Game, delta f32) {
}

fn (mut s MenuState) draw(mut g Game) {
	g.ctx.begin()
	s.btn_start.draw(g)
	g.ctx.end()
}

fn (mut s MenuState) event(mut g Game, e &gg.Event) {
	s.btn_start.event(mut g, e)
}

fn (mut s MenuState) exit(mut g Game) {
	// exit game / application
	exit(0)
}
