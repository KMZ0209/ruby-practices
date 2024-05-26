# frozen_string_literal: true

require_relative './game'
score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end
game = Game.new(shots)
puts game.score
