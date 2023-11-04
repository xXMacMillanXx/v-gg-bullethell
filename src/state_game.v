module main

import gg

struct GameState {
mut:
	sm &StateMachine
}

fn (mut s GameState) update(mut g Game, delta f32) {
	g.player.update(delta)
	for mut enemy in g.enemies {
		enemy.update()
	}
	for bullet in g.player.bullets {
		for enemy in g.enemies {
			if bullet.is_colliding(enemy) {
				g.enemies.delete(g.enemies.index(enemy))
			}
		}
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

fn (mut s GameState) event(mut g Game, e &gg.Event) {
	g.player.event(e)
}

fn (mut s GameState) exit(mut g Game) {
	// exit level -> menu
	g.states.change_state(.menu)
}
