# frozen_string_literal: true

require_relative './game'
shot_instances = ARGV[0].split(',')
game = Game.new(shot_instances)
puts game.score
