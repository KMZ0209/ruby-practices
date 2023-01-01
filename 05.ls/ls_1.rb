# frozen_string_literal: true

def files_list_and_file_count
  @files = Dir.glob('*')
  file_count = @files.size
end

def main
  column_count = (files_list_and_file_count.to_f / 3).ceil
  nested_files = @files.each_slice(column_count).to_a
  row_count = nested_files.max_by(&:size).size
  nested_files.each do |file_names|
    file_names << nil while file_names.size < row_count
  end
  max_file_size = @files.map(&:size).max
  transposed_files = nested_files.transpose
  transposed_files.each do |file_names|
    file_names.each do |file_name|
      print file_name.to_s.ljust(max_file_size + 1)
    end
    print "\n"
  end
end

main
