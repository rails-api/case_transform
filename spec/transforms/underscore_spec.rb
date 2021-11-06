# frozen_string_literal: true

require('spec_helper')

RSpec.describe(CaseTransform2) do
  describe('Transforms') do
    describe('underscore') do
      it('transforms to underscore (snake case)') do
        obj = Object.new
        scenarios = [
          { value: { "some-key": 'value' },
            expected: { some_key: 'value' } },
          { value: { 'some-key' => 'value' },
            expected: { 'some_key' => 'value' } },
          { value: { SomeKey: 'value' },
            expected: { some_key: 'value' } },
          { value: { 'SomeKey' => 'value' },
            expected: { 'some_key' => 'value' } },
          { value: { someKey: 'value' },
            expected: { some_key: 'value' } },
          { value: { 'someKey' => 'value' },
            expected: { 'some_key' => 'value' } },
          { value: :"some-value",
            expected: :some_value },
          { value: :SomeValue,
            expected: :some_value },
          { value: :someValue,
            expected: :some_value },
          { value: 'some-value',
            expected: 'some_value' },
          { value: 'SomeValue',
            expected: 'some_value' },
          { value: 'someValue',
            expected: 'some_value' },
          { value: obj,
            expected: obj },
          { value: nil,
            expected: nil },
          { value: [{ 'some-value' => 'value' }],
            expected: [{ 'some_value' => 'value' }] }
        ]
        scenarios.each do |s|
          result = CaseTransform2.underscore(s[:value])
          expect(result).to(eq(s[:expected]))
        end
      end
    end
  end
end
