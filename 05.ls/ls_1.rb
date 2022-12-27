# frozen_string_literal: true

files = Dir.glob('*')
max_file_size = files.map(&:size).max

file_count = files.size
column_count = (file_count.to_f / 3).ceil

nested_files = files.each_slice(column_count).to_a

row_count = nested_files.max_by(&:size).size
nested_files.each do |file_element|
  file_element << nil while file_element.size < row_count
end

transposed_files = nested_files.transpose
transposed_files.each do |file_names|
  file_names.each do |file_name|
    print file_name.to_s.ljust(max_file_size + 1)
  end
  print "\n"
end
