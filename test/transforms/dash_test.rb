# frozen_string_literal: true
require 'test_helper'

describe JsonKeyTransform do
  describe 'Transforms' do
    describe 'dash' do
      it 'transforms to dash (hyphenated words)' do
        obj = Object.new
        scenarios = [
          {
            value: { some_key: 'value' },
            expected: { :"some-key" => 'value' }
          },
          {
            value: { 'some_key' => 'value' },
            expected: { 'some-key' => 'value' }
          },
          {
            value: { SomeKey: 'value' },
            expected: { :"some-key" => 'value' }
          },
          {
            value: { 'SomeKey' => 'value' },
            expected: { 'some-key' => 'value' }
          },
          {
            value: { someKey: 'value' },
            expected: { :"some-key" => 'value' }
          },
          {
            value: { 'someKey' => 'value' },
            expected: { 'some-key' => 'value' }
          },
          {
            value: :some_value,
            expected: :"some-value"
          },
          {
            value: :SomeValue,
            expected: :"some-value"
          },
          {
            value: 'SomeValue',
            expected: 'some-value'
          },
          {
            value: :someValue,
            expected: :"some-value"
          },
          {
            value: 'someValue',
            expected: 'some-value'
          },
          {
            value: obj,
            expected: obj
          },
          {
            value: nil,
            expected: nil
          },
          {
            value: [
              { 'some_value' => 'value' }
            ],
            expected: [
              { 'some-value' => 'value' }
            ]
          }
        ]
        scenarios.each do |s|
          result = JsonKeyTransform.dash(s[:value])
          assert_equal s[:expected], result
        end
      end
    end
  end
end
