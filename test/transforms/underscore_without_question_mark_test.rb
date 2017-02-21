# frozen_string_literal: true
require 'test_helper'

describe CaseTransform do
  describe 'Transforms' do
    describe 'underscore_without_question_mark' do
      it 'transforms to underscore_without_question_mark (snake case)' do
        obj = Object.new
        scenarios = [
          {
            value: { :"some-key?" => 'value' },
            expected: { some_key: 'value' }
          },
          {
            value: { 'some-key?' => 'value' },
            expected: { 'some_key' => 'value' }
          },
          {
            value: { SomeKey?: 'value' },
            expected: { some_key: 'value' }
          },
          {
            value: { 'SomeKey?' => 'value' },
            expected: { 'some_key' => 'value' }
          },
          {
            value: { someKey?: 'value' },
            expected: { some_key: 'value' }
          },
          {
            value: { 'someKey?' => 'value' },
            expected: { 'some_key' => 'value' }
          },
          {
            value: :"some-value?",
            expected: :some_value
          },
          {
            value: :SomeValue?,
            expected: :some_value
          },
          {
            value: :someValue?,
            expected: :some_value
          },
          {
            value: 'some-value?',
            expected: 'some_value'
          },
          {
            value: 'SomeValue?',
            expected: 'some_value'
          },
          {
            value: 'someValue?',
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
              { 'some-value?' => 'value' }
            ],
            expected: [
              { 'some_value' => 'value' }
            ]
          }
        ]
        scenarios.each do |s|
          result = CaseTransform.underscore_without_question_mark(s[:value])
          assert_equal s[:expected], result
        end
      end
    end
  end
end
