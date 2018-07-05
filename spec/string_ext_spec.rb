# frozen_string_literal: true

require "spec_helper"

# Stolen from active support test case
# https://github.com/rails/rails/blob/78fc8530d4aa3d5d82da78fc0a763ff1d0553121/activesupport/test/inflector_test_cases.rb

RSpec.describe CaseTransform2::StringExt do
  let(:camel_to_underscore) do
    {
      "Product"               => "product",
      "SpecialGuest"          => "special_guest",
      "ApplicationController" => "application_controller",
      "Area51Controller"      => "area51_controller"
    }
  end
  let(:underscores_to_dashes) do
    {
      "street"                => "street",
      "street_address"        => "street-address",
      "person_street_address" => "person-street-address"
    }
  end

  let(:underscore_to_lower_camel) do
    {
      "product"                => "product",
      "special_guest"          => "specialGuest",
      "application_controller" => "applicationController",
      "area51_controller"      => "area51Controller"
    }
  end

  let(:symbol_to_lower_camel) do
    {
      product: "product",
      special_guest: "specialGuest",
      application_controller: "applicationController",
      area51_controller: "area51Controller"
    }
  end

  describe "#camelize" do
    it do
      symbol_to_lower_camel.each do |symbol, lower_camel|
        expect(subject.camelize(symbol, :lower)).to eq(lower_camel)
      end
    end

    it do
      underscore_to_lower_camel.each do |underscore, camel|
        expect(subject.camelize(underscore, :lower)).to eq(camel)
      end
    end

    it do
      camel_to_underscore.each do |k, v|
        expect(subject.camelize(v)).to eq(k)
      end
    end

    it do
      expect do
        subject.camelize("foo_bar", nil)
      end.to raise_error
    end
  end

  describe "#dasherize" do
    it do
      underscores_to_dashes.each do |underscored, dasherized|
        expect(subject.dasherize(underscored)).to eq(dasherized)
      end
    end
  end

  describe "#underscore" do
    it do
      camel_to_underscore.each do |camel, underscore|
        expect(subject.underscore(camel)).to eq(underscore)
      end
      expect(subject.underscore("HTMLTidy")).to eq "html_tidy"
      expect(subject.underscore("HTMLTidyGenerator")).to eq "html_tidy_generator"
    end
  end
end
