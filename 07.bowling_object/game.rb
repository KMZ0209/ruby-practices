# frozen_string_literal: true

require_relative './frame'
class Game
  def initialize(shots)
    @shots = shots
  end

  def frames
    frames = []
    @shots.each_slice(2) do |s|
      frames << s
    end
    frames = frames[0..8] << frames[9..].flatten
  end

  def last_frame(frames)
    last_frame = frames.pop
    result = last_frame.sum
    next1 = last_frame[0]
    next2 = last_frame[0] == 10 ? last_frame[2] : last_frame[1]
    result + calculate_bonus_points(frames, next1, next2)
  end

  def calculate_bonus_points(frames, next1, next2)
    result = 0
    while frames.length.positive?
      frame = frames.pop
      if frame == [10, 0]
        result += next1 + next2 + 10
        next2 = next1
      elsif frame.sum == 10
        result += next1 + 10
        next2 = frame[1]
      else
        result += frame.sum
        next2 = frame[1]
      end
      next1 = frame[0]
    end
    result
  end

  def score
    @frames = build_frames
    game_score = 0
    10.times do |idx|
      frame = @frames[idx]
      game_score += frame.score
      game_score += calculate_bonus_point(idx, frame)
    end
    game_score
  end
end
