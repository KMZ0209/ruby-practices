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
  total_block_count = 0
  files.each do |file|
    stat_file = File.lstat(file)
    total_block_count += (stat_file.blksize / 1024).truncate
  end
  puts "total #{total_block_count}"
end

def output_file_type(stat_file)
  file_type = stat_file.ftype
  FILE_TYPE[file_type]
end

def output_permission(stat_file)
  permission_count = stat_file.mode.to_s(8).slice(-3, 3)
  permission_type = permission_count.split('').map do |file_count|
    PERMISSION_TYPE[file_count]
  end
  permission_type.join('').to_s.ljust(8)
end

def output_various(stat_file)
  " #{stat_file.nlink} #{Etc.getpwuid(stat_file.uid).name} #{Etc.getgrgid(stat_file.gid).name} #{stat_file.size.to_s.rjust(4)}"
end

def output_time_stamp(stat_file)
  last_updated_time = stat_file.mtime
  " #{last_updated_time.strftime('%b %d %H:%M')} "
end

def output_files(files)
  files.each do |file|
    stat_file = File.stat(file)
    puts "#{output_file_type(stat_file)}#{output_permission(stat_file)}#{output_various(stat_file)}#{output_time_stamp(stat_file)}#{file} "
  end
end

main
