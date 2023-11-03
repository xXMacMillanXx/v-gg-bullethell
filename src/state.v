module main

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
	exit()
}

struct MenuState {
mut:
	sm &StateMachine
}

fn (mut s MenuState) update(mut g Game, delta f32) {
	// switch to game and skip menu
	g.states.change_state(.game)
}

fn (mut s MenuState) draw(mut g Game) {
	// show menu
}

fn (mut s MenuState) exit() {
	// exit game / application
}

struct GameState {
mut:
	sm &StateMachine
}

fn (mut s GameState) update(mut g Game, delta f32) {
	g.player.update(delta)
	for mut enemy in g.enemies {
		enemy.update()
	}
}

fn (mut s GameState) draw(mut g Game) {
	// start game / level
	g.ctx.begin()
	g.player.draw(g)
	for enemy in g.enemies {
		enemy.draw(g)
	}
	g.ctx.end()
}

fn (mut s GameState) exit() {
	// exit level -> menu
	s.sm.change_state(.menu)
}

struct StateMachine {
mut:
	states map[States]State
	current State
	// additional vars needed for States
}

fn StateMachine.new() &StateMachine {
	mut sm := &StateMachine { current: unsafe{nil} }
	mut st := map[States]State {}

	st[.menu] = MenuState { sm }
	st[.game] = GameState { sm }
	sm.states = &st

	sm.change_state(.menu)
	return sm
}

fn (mut s StateMachine) change_state(state States) {
	s.current = s.states[state]
}