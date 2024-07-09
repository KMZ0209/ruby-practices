# frozen_string_literal: true

require_relative 'file_formatter'

class LongFormatter < FileFormatter
  def output
    output_total_block_count
    output_long_formatted_files
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
        FileList.file_type(stat_file) + FileList.build_permission(stat_file),
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
