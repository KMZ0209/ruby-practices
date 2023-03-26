# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('lwc')
  options = { 'l' => true, 'w' => true, 'c' => true } if options.values.none?
  file_data = ARGV.select { |filename| File.file?(filename) } || $stdin.read
  select_file_data(file_data, options)
end

def select_file_data(file_data, options)
  if file_data.empty?
    output_count($stdin.read, options)
  elsif file_data.length == 1
    file_content = File.read(file_data.first)
    output_count(file_content, options)
    output_file_name(file_data.first)
  elsif file_data.length >= 2
    output_multi_file_count(file_data, options)
  end
end

def output_multi_file_count(file_data, options)
  total_lines = 0
  total_words = 0
  total_bytes = 0
  file_data.each do |file|
    file_content = File.read(file)
    line_count = line_count(file_content)
    word_count = word_count(file_content)
    byte_count = byte_count(file_content)
    output_line_count(line_count, options)
    output_word_count(word_count, options)
    output_byte_count(byte_count, options)
    output_file_name(file)
    total_lines += line_count
    total_words += word_count
    total_bytes += byte_count
  end
  output_line_count(total_lines, options)
  output_word_count(total_words, options)
  output_byte_count(total_bytes, options)
  output_file_name('total')
end

def output_count(file_content, options)
  output_line_count(line_count(file_content), options)
  output_word_count(word_count(file_content), options)
  output_byte_count(byte_count(file_content), options)
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

def output_line_count(line_count, options)
  print line_count.to_s.rjust(8) if options['l']
end

def output_word_count(word_count, options)
  print word_count.to_s.rjust(8) if options['w']
end

def output_byte_count(byte_count, options)
  print byte_count.to_s.rjust(8) if options['c']
end

def output_file_name(file)
  print "#{file}\n".to_s.rjust(8)
end

main
