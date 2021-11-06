# frozen_string_literal: true

require('spec_helper')
RSpec.describe(CaseTransform2) do
  describe('Transforms') do
    describe('camel') do
      it('transforms to camel case (PascalCase)') do
        obj = Object.new
        scenarios = [
          { value: { "some-key": 'value' },
            expected: { SomeKey: 'value' } },
          { value: { someKey: 'value' },
            expected: { SomeKey: 'value' } },
          { value: { some_key: 'value' },
            expected: { SomeKey: 'value' } },
          { value: { 'some-key' => 'value' },
            expected: { 'SomeKey' => 'value' } },
          { value: { 'someKey' => 'value' },
            expected: { 'SomeKey' => 'value' } },
          { value: { 'some_key' => 'value' },
            expected: { 'SomeKey' => 'value' } },
          { value: :"some-value",
            expected: :SomeValue },
          { value: :some_value,
            expected: :SomeValue },
          { value: :someValue,
            expected: :SomeValue },
          { value: 'some-value',
            expected: 'SomeValue' },
          { value: 'someValue',
            expected: 'SomeValue' },
          { value: 'some_value',
            expected: 'SomeValue' },
          { value: obj,
            expected: obj },
          { value: nil,
            expected: nil },
          { value: [{ some_value: 'value' }],
            expected: [{ SomeValue: 'value' }] }
        ]
        scenarios.each do |s|
          result = CaseTransform2.camel(s[:value])
          expect(result).to(eq(s[:expected]))
        end
      end
    end
  end
end
