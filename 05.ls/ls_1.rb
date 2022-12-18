# frozen_string_literal: true

find_files = Dir.glob('*')
max_size = find_files.map(&:size).max
files = []
all_files = find_files.size
n = if (all_files % 3).zero?
      all_files / 3
    else
      all_files / 3 + 1
    end
find_files.each_slice(n) do |s|
  files << s
end

max = files.max_by(&:size).size

files = files.each do |a|
  a << nil while a.size < max
end

files = files.transpose

files.compact

files.map { |it| it.is_a?(Array) ? it.values_at(0...max_size) : it }

(0..(files.size - 1)).each do |i|
  out_files = []
  (0..(files[i].size - 1)).each do |j|
    out_files << files[i][j].to_s.ljust(max_size + 1)
  end

  puts out_files.join
end
