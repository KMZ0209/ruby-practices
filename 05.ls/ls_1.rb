# frozen_string_literal: true

find_files = Dir.glob('*')
files = []
find_files.each_slice(5) do |s|
  files << s
end

files.compact!

max_size = files.map(&:size).max
files.map! { |it| it.is_a?(Array) ? it.values_at(0...max_size) : it }
files = files.transpose

(0..(files.size - 1)).each do |i|
  out_files = []
  (0..(files[i].size - 1)).each do |j|
    out_files << files[i][j].to_s.ljust(max_size + 10)
  end
  puts out_files.join
end
