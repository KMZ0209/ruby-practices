# frozen_string_literal: true #Rubocop対応

find_files = Dir.glob('*')
files = find_files.each_slice(3).to_a

(0..(files.size - 1)).each do |i|
  out_files = []
  (0..(files[i].size - 1)).each do |j|
    out_files << files[j][i].ljust(12)
  end
  puts out_files.join
end
