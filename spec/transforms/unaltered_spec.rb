# frozen_string_literal: true

require('spec_helper')

RSpec.describe(CaseTransform2) do
  describe '.unaltered' do
    it "doesn't transform the given parameter" do
      ['Hello World', 'hello_world', 'hello World'].each do |arg|
        expect(subject.unaltered(arg)).to eq(arg)
      end
    end
  end
end
