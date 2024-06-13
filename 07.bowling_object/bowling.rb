# frozen_string_literal: true

require_relative './game'
shot_marks = ARGV[0].split(',')
game = Game.new(shot_marks)
puts game.score
