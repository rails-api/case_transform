# frozen_string_literal: true
require 'test_helper'

describe JsonKeyTransform do
  describe 'Transforms' do
    describe 'underscore' do
      it 'transforms to underscore (snake case)' do
        obj = Object.new
        scenarios = [
          {
            value: { :"some-key" => 'value' },
            expected: { some_key: 'value' }
          },
          {
            value: { 'some-key' => 'value' },
            expected: { 'some_key' => 'value' }
          },
          {
            value: { SomeKey: 'value' },
            expected: { some_key: 'value' }
          },
          {
            value: { 'SomeKey' => 'value' },
            expected: { 'some_key' => 'value' }
          },
          {
            value: { someKey: 'value' },
            expected: { some_key: 'value' }
          },
          {
            value: { 'someKey' => 'value' },
            expected: { 'some_key' => 'value' }
          },
          {
            value: :"some-value",
            expected: :some_value
          },
          {
            value: :SomeValue,
            expected: :some_value
          },
          {
            value: :someValue,
            expected: :some_value
          },
          {
            value: 'some-value',
            expected: 'some_value'
          },
          {
            value: 'SomeValue',
            expected: 'some_value'
          },
          {
            value: 'someValue',
            expected: 'some_value'
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
              { 'some-value' => 'value' }
            ],
            expected: [
              { 'some_value' => 'value' }
            ]
          }
        ]
        scenarios.each do |s|
          result = JsonKeyTransform.underscore(s[:value])
          assert_equal s[:expected], result
        end
      end
    end
  end
end
