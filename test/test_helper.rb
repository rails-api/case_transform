# frozen_string_literal: true
require 'bundler/setup'

begin
  require 'simplecov'
  Coverage.start
rescue LoadError
  STDERR.puts 'Running without SimpleCov'
end

require 'pry-byebug'
require 'json_key_transform'

require 'minitest'
require 'minitest/autorun'
Minitest.backtrace_filter = Minitest::BacktraceFilter.new
