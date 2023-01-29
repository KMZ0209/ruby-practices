# frozen_string_literal: true

require 'optparse'
require 'etc'

COLUMN_COUNT = 3

FILE_TYPE = {
  'file' => '-',
  'link' => 'l',
  'directory' => 'd'
}.freeze

PERMISSION_TYPE = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

def main
  options = ARGV.getopts('arl')
  if options['r'] && options['l'] && options['a']
    files = Dir.glob('*', File::FNM_DOTMATCH).reverse
    output_ls_command_option_l(files)
  elsif options['a'] && options['r']
    files = Dir.glob('*', File::FNM_DOTMATCH).reverse
    output_ls_command_option_a_r(files)
  elsif options['a'] && options['l']
    files = Dir.glob('*', File::FNM_DOTMATCH)
    output_ls_command_option_l(files)
  elsif options['r'] && options['l']
    files = Dir.glob('*').reverse
    output_ls_command_option_l(files)
  elsif options['a']
    files = Dir.glob('*', File::FNM_DOTMATCH)
    output_ls_command_option_a_r(files)
  elsif options['r']
    files = Dir.glob('*').reverse
    output_ls_command_option_a_r(files)
  elsif options['l']
    files = Dir.glob('*')
    output_ls_command_option_l(files)
  else
    Dir.glob('*')
  end
end

def output_ls_command_option_l(files)
  output_total_block_count(files)
  output_files_l(files)
end

def output_ls_command_option_a_r(files)
  transposed_files = build_transposed_files(files)
  max_file_size = files.map(&:size).max
  output_files(transposed_files, max_file_size)
end

def build_transposed_files(files)
  row_count = (files.size.to_f / COLUMN_COUNT).ceil
  nested_files = files.each_slice(row_count).to_a
  nested_files.each do |file_names|
    file_names << nil while file_names.size < row_count
  end
  nested_files.transpose
end

def output_files(transposed_files, max_file_size)
  transposed_files.each do |file_names|
    file_names.each do |file_name|
      print file_name.to_s.ljust(max_file_size + 1)
    end
    print "\n"
  end
end

def output_total_block_count(files)
  total_block_count = files.sum { |file_count| File.lstat(file_count).blocks }
  puts "total #{total_block_count}"
end

def build_permission(stat_file)
  permission_value = stat_file.mode.to_s(8).slice(-3, 3)
  permission_types = permission_value.each_char.map do |file_count|
    PERMISSION_TYPE[file_count]
  end
  permission_types.join('')
end

def output_files_l(files)
  files.each do |file|
    stat_file = File.stat(file)
    output_data = [
      FILE_TYPE[stat_file.ftype] + build_permission(stat_file),
      stat_file.nlink,
      Etc.getpwuid(stat_file.uid).name,
      Etc.getgrgid(stat_file.gid).name,
      stat_file.size.to_s.rjust(4),
      stat_file.mtime.strftime('%b %d %H:%M'),
      file
    ]
    puts output_data.join(' ')
  end
end

main
