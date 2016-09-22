require 'benchmark/ips'
require 'json'
require 'awesome_print'
# Add benchmarking runner from ruby-bench-suite
# https://github.com/ruby-bench/ruby-bench-suite/blob/master/rails/benchmarks/support/benchmark_rails.rb
module Benchmark
  module CaseTransform

    # extend Benchmark with an `ams` method
    def bench(label = nil, time:, disable_gc: true, warmup: 3, &block)
      fail ArgumentError.new, 'block should be passed' unless block_given?

      if disable_gc
        GC.disable
      else
        GC.enable
      end

      report = Benchmark.ips(time, warmup, true) do |x|
        x.report(label) { yield }
      end

      entry = report.entries.first

      output = {
        label: label,
        iterations_per_second: entry.ips,
        iterations_per_second_standard_deviation: entry.error_percentage,
        total_allocated_objects_per_iteration: count_total_allocated_objects(&block)
      }

      ap output
      output
    end

    def count_total_allocated_objects
      if block_given?
        key =
          if RUBY_VERSION < '2.2'
            :total_allocated_object
          else
            :total_allocated_objects
          end

        before = GC.stat[key]
        yield
        after = GC.stat[key]
        after - before
      else
        -1
      end
    end
  end

  extend Benchmark::CaseTransform
end
