# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('lwc')
  files = ARGV
  file_data = ARGV.select { |arg| File.file?(arg) } || $stdin.read
  if file_data.empty?
    output_standard_input_options_count(options)
  else
    output_files_count(options, file_data) if options['l'] || options['w'] || options['c']
    output_multi_file_count(files, file_data) if file_data.length >= 2
  end
end

# 標準入力
def output_standard_input_options_count(options)
  input = $stdin.read
  if options['l'] || options['w'] || options['c']
    print input.count("\n").to_s.ljust(8) if options['l']
    print input.split(/\s+/).size.to_s.ljust(8) if options['w']
    print input.bytesize.to_s.ljust(8) if options['c']
  else
    output_standard_input_count(input)
  end
end

# 標準入力、オプションなし
def output_standard_input_count(input)
  print input.count("\n").to_s.ljust(8)
  print input.split(/\s+/).size.to_s.ljust(8)
  print input.bytesize.to_s.ljust(8)
end

# オプション
def output_files_count(options, file_data)
  if options.empty?
    output_single_file_count(file_data)
  else
    file_data.each do |file|
      line_count(file_data) if options['l']
      word_count(file_data) if options['w']
      byte_count(file_data) if options['c']
      print "#{file}\n"
    end
  end
end

# ファイルひとつ
def output_single_file_count(file_data)
  file_data.each do |file|
    print File.read(file).count("\n").to_s.ljust(4)
    print File.read(file).split(/\s+/).size.to_s.ljust(4)
    print File.read(file).bytesize.to_s.ljust(5)
    print "#{file}\n".to_s.rjust(7)
  end
end

# 行数える
def line_count(file_data)
  file_data.each do |file|
    print File.read(file).count("\n").to_s.ljust(4)
  end
end

# 単語数数える
def word_count(file_data)
  file_data.each do |file|
    print File.read(file).split(/\s+/).size.to_s.ljust(4)
  end
end

# バイト数数える
def byte_count(file_data)
  file_data.each do |file|
    print File.read(file).bytesize.to_s.ljust(5)
  end
end

# ファイル名が複数個のとき
def output_multi_file_count(files, _file_data)
  total_lines = 0
  total_words = 0
  total_bytes = 0
  files.each do |file|
    file_content = File.read(file)
    total_lines += file_content.count("\n")
    total_words += file_content.split(/\s+/).size
    total_bytes += file_content.bytesize
    print file_content.count("\n").to_s.ljust(4)
    print file_content.split(/\s+/).size.to_s.ljust(4)
    print file_content.bytesize.to_s.ljust(5)
    print "#{file}\n".to_s.rjust(7)
  end
  print total_lines.to_s.ljust(4) + total_words.to_s.ljust(4) + total_bytes.to_s.ljust(5)
  print "total\n".to_s.rjust(7)
end

main
