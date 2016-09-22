# frozen_string_literal: true
require_relative './test/benchmark_support'
require_relative './test/ruby_case_transform'
require_relative './lib/case_transform'

time = 10
disable_gc = true

hash = {
  multi_word_key: {
    some_array: [
      {
        data: {
          two_three: 4
        }
      }
    ]
  }
}

Benchmark.bench('camel',
  time: time, disable_gc: disable_gc,
  rust: -> { CaseTransform.camel(hash) },
  ruby: -> { RubyCaseTransform.camel(hash) })

Benchmark.bench('camel_lower',
  time: time, disable_gc: disable_gc,
  rust: -> { CaseTransform.camel_lower(hash) },
  ruby: -> { RubyCaseTransform.camel_lower(hash) })

Benchmark.bench('dash',
  time: time, disable_gc: disable_gc,
  rust: -> { CaseTransform.dash(hash) },
  ruby: -> { RubyCaseTransform.dash(hash) })

Benchmark.bench('unaltered',
  time: time, disable_gc: disable_gc,
  rust: -> { CaseTransform.unaltered(hash) },
  ruby: -> { RubyCaseTransform.unaltered(hash) })

Benchmark.bench('underscore',
  time: time, disable_gc: disable_gc,
  rust: -> { CaseTransform.underscore(hash) },
  ruby: -> { RubyCaseTransform.underscore(hash) })
