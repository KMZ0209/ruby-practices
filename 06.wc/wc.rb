# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('lwc')
  options = { 'l' => true, 'w' => true, 'c' => true } if options.values.none?
  files = ARGV
  file_data = ARGV.select { |filename| File.file?(filename) } || $stdin.read
  select_file_data(file_data, files, options)
end

def select_file_data(file_data, files, options)
  if file_data.empty?
    output_standard_input_count(options)
  elsif file_data.length == 1
    output_files_count(file_data, options)
  elsif file_data.length >= 2
    output_multi_file_options_count(files, options)
  end
end

def output_standard_input_count(options)
  input = $stdin.read
  print line_count(input).to_s.rjust(8) if options['l']
  print word_count(input).to_s.rjust(8) if options['w']
  print byte_count(input).to_s.rjust(8) if options['c']
end

def output_files_count(file_data, options)
  output_line_count(file_data) if options['l']
  output_word_count(file_data) if options['w']
  output_byte_count(file_data) if options['c']
  output_file(file_data)
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

def output_multi_file_options_count(files, options)
  total_lines = 0
  total_words = 0
  total_bytes = 0
  files.each do |file|
    file_content = File.read(file)
    line_count = line_count(file_content)
    word_count = word_count(file_content)
    byte_count = byte_count(file_content)
    print line_count.to_s.rjust(4) if options['l']
    print word_count.to_s.rjust(4) if options['w']
    print byte_count.to_s.rjust(6) if options['c']
    print "#{file}\n".to_s.rjust(8)
    total_lines += line_count
    total_words += word_count
    total_bytes += byte_count
  end
  print total_lines.to_s.rjust(4) if options['l']
  print total_words.to_s.rjust(4) if options['w']
  print total_bytes.to_s.rjust(6) if options['c']
  print "total\n".to_s.rjust(8)
end

main
