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

Benchmark.bench('CaseTransform: camel', time: time, disable_gc: disable_gc) do
  CaseTransform.camel(hash)
end

Benchmark.bench('Pure Ruby: camel', time: time, disable_gc: disable_gc) do
  RubyCaseTransform.camel(hash)
end

Benchmark.bench('CaseTransform: camel_lower', time: time, disable_gc: disable_gc) do
  CaseTransform.camel_lower(hash)
end

Benchmark.bench('Pure Ruby: camel_lower', time: time, disable_gc: disable_gc) do
  RubyCaseTransform.camel_lower(hash)
end

Benchmark.bench('CaseTransform: dash', time: time, disable_gc: disable_gc) do
  CaseTransform.dash(hash)
end

Benchmark.bench('Pure Ruby: dash', time: time, disable_gc: disable_gc) do
  RubyCaseTransform.dash(hash)
end

Benchmark.bench('CaseTransform: unaltered', time: time, disable_gc: disable_gc) do
  CaseTransform.unaltered(hash)
end

Benchmark.bench('Pure Ruby: unaltered', time: time, disable_gc: disable_gc) do
  RubyCaseTransform.unaltered(hash)
end

Benchmark.bench('CaseTransform: underscore', time: time, disable_gc: disable_gc) do
  CaseTransform.underscore(hash)
end

Benchmark.bench('Pure Ruby: underscore', time: time, disable_gc: disable_gc) do
  RubyCaseTransform.underscore(hash)
end
