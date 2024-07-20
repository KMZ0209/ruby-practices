# frozen_string_literal: true

require 'optparse'
require_relative 'file_list'

class LsCommand
  def initialize
    @options = parse_options
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

  def run
    file_list = FileList.new(@options)
    file_list.format_files
  end
end

LsCommand.new.run
