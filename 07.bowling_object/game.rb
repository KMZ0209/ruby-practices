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

  def calculate_bonus_point(idx, frame)
    return 0 if idx >= 9

    if frame.strike?
      next_frame = @frames[idx + 1]
      next_two_frame = @frames[idx + 2]
      if next_frame.strike? && next_two_frame
        [next_frame.first_shot.score, next_two_frame.first_shot.score].sum
      else
        [next_frame.first_shot.score, next_frame.second_shot.score].sum
      end
    elsif frame.spare?
      @frames[idx + 1].first_shot.score
    else
      0
    end
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
