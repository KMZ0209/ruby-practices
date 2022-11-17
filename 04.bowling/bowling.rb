# frozen_string_literal: true

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

frames = []
shots.each_slice(2) do |s|
  frames << s
end

frames = frames[0..8] << frames[9..].flatten

last_frame = frames.pop
result = last_frame.sum
next1 = last_frame[0]
next2 = last_frame[0] == 10 ? last_frame[2] : last_frame[1]

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
p result
