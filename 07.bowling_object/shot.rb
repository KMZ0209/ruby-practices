# frozen_string_literal: true

class Shot
  STRIKE_MARK = 'X'
  attr_reader :score

  def initialize(mark)
    @score = mark == STRIKE_MARK ? 10 : mark.to_i
  end

  def strike?
    @score == 10
  end
end
