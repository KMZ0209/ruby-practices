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

array = frames[9..]
frames = frames[0..8] << array

result = 0
frame = frames.pop
frame.each do |last_frame|
  result += last_frame.sum
end
if frame.size == 1
  next1 = frame[0]
  next2 = []
else
  next1, next2 = frame
end
while frames.length.positive?
  frame = frames.pop
  result += if frame == [10, 0]
              if next1 == [10, 0]
                10 + 10 + next2[0]
              else
                10 + next1.sum
              end
            elsif frame.sum == 10
              10 + next1[0]
            else
              frame.sum
            end
  next2 = next1
  next1 = frame
end
p result
