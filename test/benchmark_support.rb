# frozen_string_literal: true
require 'benchmark/ips'
require 'json'
require 'awesome_print'
require 'pry-byebug'
# Add benchmarking runner from ruby-bench-suite
# https://github.com/ruby-bench/ruby-bench-suite/blob/master/rails/benchmarks/support/benchmark_rails.rb
module Benchmark
  module CaseTransform
    def bench(label = nil, time: 10, disable_gc: true, warmup: 3, rust: nil, ruby: nil)

      if disable_gc
        GC.disable
      else
        GC.enable
      end

      Benchmark.ips(time, warmup, true) do |x|
        x.report('Rust: ' + label) { rust.call }
        x.report('Ruby: ' + label) { ruby.call }
        x.compare!
      end
    end
  end

  extend Benchmark::CaseTransform
end
