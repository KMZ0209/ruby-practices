# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative 'long_formatter'
require_relative 'short_formatter'

COLUMN_COUNT = 3

class FileList
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
    files = @options['a'] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    @options['r'] ? files.reverse : files
  end

  def format_files
    formatter = @options['l'] ? LongFormatter.new(@files) : ShortFormatter.new(@files)
    formatter.output
  end

  def self.file_type(stat_file)
    FILE_TYPE[stat_file.ftype]
  end

  def self.build_permission(stat_file)
    permission_value = stat_file.mode.to_s(8).slice(-3, 3)
    permission_value.chars.map { |c| PERMISSION_TYPE[c] }.join('')
  end
end
