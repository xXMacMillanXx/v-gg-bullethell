module main

interface State {
	sm &StateMachine
	// add methods
}

struct StateMachine {
mut:
	states map[string]State
	current State = unsafe{nil}
	// additional vars needed for States
}

fn StateMachine.new() &StateMachine {
	mut sm := &StateMachine {}
	mut st := map[string]State {}

	// st['menu'] = MenuState { sm }
	sm.states = &st

	// sm.change_state('menu')
	return sm
}

fn (mut s StateMachine) change_state(state string) {
	s.current = s.states[state]
}