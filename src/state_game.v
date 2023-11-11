module main

import gg

struct GameState {
mut:
	sm &StateMachine
	player Player
	enemies []Enemy
}

fn GameState.new(sm &StateMachine) GameState {
	mut player := Player.new(100, 300, 25, 50)
	mut enemies := []Enemy{}
	enemies << Enemy.new(200, 100, 25, 25)
	enemies << Enemy.new(300, 100, 25, 25)
	enemies << Enemy.new(400, 100, 25, 25)
	return GameState{ sm, player, enemies }
}

fn (mut s GameState) update(mut g Game, delta f32) {
	s.player.update(delta)
	for mut enemy in s.enemies {
		enemy.update()
	}
	for bullet in s.player.bullets {
		for enemy in s.enemies {
			if bullet.is_colliding(enemy) {
				s.enemies.delete(s.enemies.index(enemy))
			}
		}
	}
	for bomb in s.player.bombs {
		for enemy in s.enemies {
			if bomb.is_colliding(enemy) {
				s.enemies.delete(s.enemies.index(enemy))
			}
		}
	}
}

fn (mut s GameState) draw(mut g Game) {
	g.ctx.begin()
	s.player.draw(g)
	for enemy in s.enemies {
		enemy.draw(g)
	}
	g.ctx.end()
}

fn (mut s GameState) event(mut g Game, e &gg.Event) {
	s.player.event(e)
}

fn (mut s GameState) exit(mut g Game) {
	// exit level -> menu
	g.states.change_state(.menu)
}
