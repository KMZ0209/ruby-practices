# frozen_string_literal: true

files = Dir.glob('*')
sort_files = files
max_file_size = sort_files.map(&:size).max

file_count = sort_files.size
column_count = (file_count.to_f / 3).ceil

all_files = sort_files
nested_files = all_files.each_slice(column_count).to_a

 row_count = nested_files.max_by(&:size).size
 nested_files.each do |file_element|
   file_element << nil while file_element.size < row_count
 end

 transposed_file = nested_files.transpose
  transposed_file.each do |file_names|
    out_files = []
    file_names.each do |file_name|
      out_files << file_name.to_s.ljust(max_file_size + 1)
    end
    puts out_files.join
  end
