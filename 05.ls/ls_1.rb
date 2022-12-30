# frozen_string_literal: true

def print_files_count_in_columns(column_count: 3)
  files = Dir.glob('*')
  file_count = files.size
  column_count = (file_count.to_f / column_count).ceil
  nested_files = files.each_slice(column_count).to_a
  row_count = nested_files.max_by(&:size).size
  nested_files.each do |file_names|
    file_names << nil while file_names.size < row_count
  end
  max_file_size = files.map(&:size).max
  transposed_files = nested_files.transpose
  transposed_files.each do |file_names|
    file_names.each do |file_name|
      count = max_file_size
      print file_name.to_s.ljust(count + 1)
    end
    print "\n"
  end
end

def file_names_and_max_file_size
  files = Dir.glob('*')
  files.max_by(&:size)
end
print_files_count_in_columns
