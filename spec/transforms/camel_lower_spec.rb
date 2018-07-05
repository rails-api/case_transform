# frozen_string_literal: true

require("spec_helper")
RSpec.describe(CaseTransform2) do
  describe("Transforms") do
    describe("camel_lower") do
      it("transforms to lowerCamelCase") do
        obj = Object.new
        scenarios = [
          { value: { :"some-key" => "value" },
            expected: { someKey: "value" } },
          { value: { SomeKey: "value" },
            expected: { someKey: "value" } },
          { value: { some_key: "value" },
            expected: { someKey: "value" } },
          { value: { "some-key" => "value" },
            expected: { "someKey" => "value" } },
          { value: { "SomeKey" => "value" },
            expected: { "someKey" => "value" } },
          { value: { "some_key" => "value" },
            expected: { "someKey" => "value" } },
          { value: :"some-value",
            expected: :someValue },
          { value: :SomeValue,
            expected: :someValue },
          { value: :some_value,
            expected: :someValue },
          { value: "some-value",
            expected: "someValue" },
          { value: "SomeValue",
            expected: "someValue" },
          { value: "some_value",
            expected: "someValue" },
          { value: obj,
            expected: obj },
          { value: nil,
            expected: nil },
          { value: [{ some_value: "value" }],
            expected: [{ someValue: "value" }] }
        ]
        scenarios.each do |s|
          result = CaseTransform2.camel_lower(s[:value])
          expect(result).to(eq(s[:expected]))
        end
      end
    end
  end
end
