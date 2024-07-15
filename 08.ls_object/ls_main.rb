# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative 'long_formatter'
require_relative 'short_formatter'

COLUMN_COUNT = 3

class FileList
  def initialize
    @options = parse_options
    @files = fetch_files
  end

  def parse_options
    options = {}
    OptionParser.new do |opts|
      opts.on('-a') { options['a'] = true }
      opts.on('-r') { options['r'] = true }
      opts.on('-l') { options['l'] = true }
    end.parse(ARGV)
    options
  end

  def fetch_files
    pattern = '*'
    flag = @options['a'] ? File::FNM_DOTMATCH : 0
    files = Dir.glob(pattern, flag)
    @options['r'] ? files.reverse : files
  end

  def format_files
    formatter = @options['l'] ? LongFormat.new(@files) : ShortFormat.new(@files)
    formatter.output
  end
end
