# frozen_string_literal: true

find_files = Dir.glob('*')
files = []
find_files.each_slice(3) do |s|
  files << s
end

(0..(files.size - 1)).each do |i|
  out_files = []
  (0..(files[i].size - 1)).each do |j|
    out_files << files[j][i]
  end
  puts out_files.join("\t")
end
