module main

import gg

enum States {
	menu
	game
}

interface State {
mut:
	sm &StateMachine
	// add methods
	update(mut Game, f32)
	draw(mut Game)
	event(mut Game, &gg.Event)
	exit(mut Game)
}

[heap]
struct StateMachine {
mut:
	states map[States]State
	current State
	// additional vars needed for States
}

fn StateMachine.new() &StateMachine {
	mut sm := &StateMachine { current: unsafe{nil} }
	mut st := map[States]State {}

	st[.menu] = MenuState.new(sm)
	st[.game] = GameState.new(sm)
	sm.states = &st

	sm.change_state(.menu)
	return sm
}

fn (mut s StateMachine) change_state(state States) {
	s.current = s.states[state]
}
