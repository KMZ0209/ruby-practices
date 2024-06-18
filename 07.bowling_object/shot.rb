# frozen_string_literal: true

class Shot
  attr_reader :score

  def initialize(mark)
    @score = mark_to_score(mark)
  end

  def strike?
    @score == 10
  end

  def mark_to_score(mark)
    case mark
    when 'X'
      10
    else
      mark.to_i
    end
  end
end
