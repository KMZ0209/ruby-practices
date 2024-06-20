# frozen_string_literal: true

require_relative './shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_shot, second_shot, third_shot = nil)
    @first_shot = first_shot
    @second_shot = second_shot
    @third_shot = third_shot
  end

  def score
    [@first_shot, @second_shot, @third_shot].compact.map(&:score).sum
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    !strike? && @first_shot.score + @second_shot.score == 10
  end
end
