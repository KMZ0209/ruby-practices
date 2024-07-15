# frozen_string_literal: true

require 'etc'
require_relative 'long_formatter'
require_relative 'short_formatter'

class FileList
  def initialize(options)
    @options = options
    @files = fetch_files
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
