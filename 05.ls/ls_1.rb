# frozen_string_literal: true

file_list = Dir.glob('*')
max_value = file_list.map(&:size).max
files = []
number_of_files = file_list.size
n = if (number_of_files % 3).zero?
      number_of_files.to_f / 3
    else
      number_of_files.to_f / 3 + 1.ceil
    end
files = file_list.each_slice(n).to_a

most_common_elements = files.max_by(&:size).size
files = files.each do |file_element|
  file_element << nil while file_element.size < most_common_elements
end

transposed_file = files.transpose
transposed_file.map { |each_file| [each_file] }
(0..(transposed_file.size - 1)).each do |i|
  out_files = []
  (0..(transposed_file[i].size - 1)).each do |j|
    out_files << transposed_file[i][j].to_s.ljust(max_value + 1)
  end
  puts out_files.join
end
