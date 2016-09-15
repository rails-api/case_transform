# frozen_string_literal: true
require 'bundler/setup'

require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start if ENV['CODECLIMATE_REPO_TOKEN']

require 'pry-byebug'
require 'case_transform'

require 'minitest'
require 'minitest/autorun'
Minitest.backtrace_filter = Minitest::BacktraceFilter.new
