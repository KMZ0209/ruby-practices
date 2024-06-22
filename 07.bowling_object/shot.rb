# frozen_string_literal: true

class Shot
  PERFECT_SCORE_MARK = 'X'
  PERFECT_SCORE = 10

  attr_reader :score

  def initialize(mark)
    @score = mark == PERFECT_SCORE_MARK ? PERFECT_SCORE : mark.to_i
  end

  def perfect_score
    @score == PERFECT_SCORE
  end
end
