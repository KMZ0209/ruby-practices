# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('lwc')
  files = Dir.glob('*')
  if options['l'] && options['w'] && options['c']
    output_for_line_word_byte_count(files)
  elsif options['l'] && options['w']
    output_for_line_word_count(files)
  elsif options['w'] && options['c']
    output_for_word_byte_count(files)
  elsif options['l'] && options['c']
    output_for_line_byte_count(files)
  elsif options['l']
    output_for_line_count(files)
  elsif options['w']
    output_for_word_count(files)
  elsif options['c']
    output_for_byte_count(files)
  elsif ARGV[0]
    output_for_file_names(files)
  else
    output_for_standard_input(files)
  end
end

def output_for_line_word_byte_count(files)
  file = files.pop
  print File.read(file).count("\n").to_s.ljust(4)
  print word_count(file).to_s.ljust(4)
  print byte_count(file).to_s.ljust(5)
  print "#{file}\n".to_s.ljust(4)
end

def output_for_line_word_count(files)
  file = files.pop
  print File.read(file).count("\n").to_s.ljust(4)
  print word_count(file).to_s.ljust(4)
  print "#{file}\n".to_s.ljust(4)
end

def output_for_word_byte_count(files)
  file = files.pop
  print word_count(file).to_s.ljust(4)
  print byte_count(file).to_s.ljust(5)
  print "#{file}\n".to_s.ljust(4)
end

def output_for_line_byte_count(files)
  file = files.pop
  print File.read(file).count("\n").to_s.ljust(4)
  print byte_count(file).to_s.ljust(5)
  print "#{file}\n".to_s.ljust(4)
end

def output_for_line_count(files)
  file = files.pop
  output_line_count(file)
end

def output_for_word_count(files)
  file = files.pop
  output_word_count(file)
end

def output_for_byte_count(files)
  file = files.pop
  output_byte_count(file)
end

def line_count(file)
  File.read(file).count("\n")
end

def word_count(file)
  words = File.read(file).split(/\s+/).size
  words.to_i
end

def byte_count(file)
  bytes = File.read(file).bytesize
  bytes.to_i
end

def total_line_count(files)
  files.sum { |file| line_count(file) }
end

def total_word_count(files)
  files.sum { |file| word_count(file) }
end

def total_byte_count(files)
  files.sum { |file| byte_count(file) }
end

def output_line_count(file)
  print File.read(file).count("\n").to_s.ljust(4)
  print "#{file}\n"
end

def output_word_count(file)
  print word_count(file).to_s.ljust(4)
  print "#{file}\n"
end

def output_byte_count(file)
  print byte_count(file).to_s.ljust(5)
  print "#{file}\n "
end

def output_for_standard_input(_files)
  input = $stdin.read
  output_standard_input_count(input)
end

def output_standard_input_count(input)
  print input.count("\n").to_s.ljust(8)
  print input.split(/\s+/).size.to_s.ljust(8)
  print "#{input.bytesize.to_s.ljust(8)}\n"
end

def output_for_file_names(files)
  files.each do |file|
    print File.read(file).count("\n").to_s.rjust(4)
    print word_count(file).to_s.rjust(5)
    print byte_count(file).to_s.rjust(5)
    print "#{file}\n".to_s.rjust(7)
  end
  print total_line_count(files).to_s.rjust(4)
  print total_word_count(files).to_s.rjust(5)
  print total_byte_count(files).to_s.rjust(5)
  print "total\n".to_s.rjust(7)
end

main
