# frozen_string_literal: true

require_relative 'file_list'
require_relative 'file_format'

class LongFormat < FileFormat
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

  def output
    output_total_block_count
    output_long_formatted_files
  end

  def self.file_type(stat_file)
    FILE_TYPE[stat_file.ftype]
  end

  def self.build_permission(stat_file)
    permission_value = stat_file.mode.to_s(8).slice(-3, 3)
    permission_value.chars.map { |c| PERMISSION_TYPE[c] }.join('')
  end

  private

  def output_total_block_count
    total_block_count = @files.sum { |file| File.lstat(file).blocks }
    puts "total #{total_block_count}"
  end

  def output_long_formatted_files
    @files.each do |file|
      stat_file = File.stat(file)
      output_data = [
        LongFormat.file_type(stat_file) + LongFormat.build_permission(stat_file),
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
end
