# frozen_string_literal: true

require_relative './game'

raw_shots = ARGV[0].split(',')
game = Game.new(raw_shots)
puts game.score
