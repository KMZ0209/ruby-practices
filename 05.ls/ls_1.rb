# frozen_string_literal: true

require 'etc'

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
  files = Dir.glob('*')
  output_total_block_count(files)
  output_files(files)
end

def output_total_block_count(files)
  total_block_count = files.sum { |file_count| File.lstat(file_count).blocks }
  puts "total #{total_block_count}"
end

def output_permission(stat_file)
  permission_count = stat_file.mode.to_s(8).slice(-3, 3)
  permission_type = permission_count.split('').map do |file_count|
    PERMISSION_TYPE[file_count]
  end
  permission_type.join('').to_s.ljust(8)
end

def output_files(files)
  files.each do |file|
    stat_file = File.stat(file)
    output_data = [
      FILE_TYPE[stat_file.ftype] + output_permission(stat_file),
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
