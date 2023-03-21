# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('lwc')
  files = ARGV
  file_data = ARGV.select { |arg| File.file?(arg) } || $stdin.read
  option = options['l'] || options['w'] || options['c']
  if file_data.empty?
    option ? output_standard_input_options_count(options) : output_standard_input_count
  elsif file_data.length >= 2
    option ? output_multi_file_options_count(files, options) : output_multi_file_count(files)
  elsif file_data.length == 1
    option ? output_files_count(file_data, options) : output_single_file_count(file_data)
  end
end

# 標準入力
def output_standard_input_options_count(options)
  input = $stdin.read
  print input.count("\n").to_s.rjust(8) if options['l']
  print input.split(/\s+/).size.to_s.rjust(8) if options['w']
  print input.bytesize.to_s.rjust(8) if options['c']
end

def output_standard_input_count
  input = $stdin.read
  print input.count("\n").to_s.rjust(8)
  print input.split(/\s+/).size.to_s.rjust(8)
  print input.bytesize.to_s.rjust(8)
end

def output_files_count(file_data, options)
  output_line_count(file_data) if options['l']
  output_word_count(file_data) if options['w']
  output_byte_count(file_data) if options['c']
  output_file(file_data)
end

def output_single_file_count(file_data)
  output_line_count(file_data)
  output_word_count(file_data)
  output_byte_count(file_data)
  output_file(file_data)
end

def output_line_count(file_data)
  file_data.each do |file|
    print File.read(file).count("\n").to_s.rjust(4)
  end
end

def output_word_count(file_data)
  file_data.each do |file|
    print File.read(file).split(/\s+/).size.to_s.rjust(4)
  end
end

def output_byte_count(file_data)
  file_data.each do |file|
    print File.read(file).bytesize.to_s.rjust(6)
  end
end

def output_file(file_data)
  file_data.each do |file|
    print "#{file}\n".to_s.rjust(8)
  end
end

def output_multi_file_count(files)
  total_lines = 0
  total_words = 0
  total_bytes = 0
  files.each do |file|
    file_content = File.read(file)
    total_lines += line_count(file_content)
    total_words += word_count(file_content)
    total_bytes += byte_count(file_content)
    print line_count(file_content).to_s.rjust(4)
    print word_count(file_content).to_s.rjust(4)
    print byte_count(file_content).to_s.rjust(6)
    print "#{file}\n".to_s.rjust(8)
  end
  print total_lines.to_s.rjust(4)
  print total_words.to_s.rjust(4)
  print total_bytes.to_s.rjust(6)
  print "total\n".to_s.rjust(8)
end

def output_multi_file_options_count(files, options)
  total_lines = 0
  total_words = 0
  total_bytes = 0
  files.each do |file|
    file_content = File.read(file)
    total_lines += line_count(file_content)
    total_words += word_count(file_content)
    total_bytes += byte_count(file_content)
    print line_count(file_content).to_s.rjust(4) if options['l']
    print word_count(file_content).to_s.rjust(4) if options['w']
    print byte_count(file_content).to_s.rjust(6) if options['c']
    print "#{file}\n".to_s.rjust(8)
  end
  print total_lines.to_s.rjust(4) if options['l']
  print total_words.to_s.rjust(4) if options['w']
  print total_bytes.to_s.rjust(6) if options['c']
  print "total\n".to_s.rjust(8)
end

def line_count(file_content)
  file_content.count("\n").to_i
end

def word_count(file_content)
  file_content.split(/\s+/).size.to_i
end

def byte_count(file_content)
  file_content.bytesize.to_i
end

main
