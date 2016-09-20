# frozen_string_literal: true

require 'case_transform/version'
require 'thermite/config'
require 'fiddle'

ruby_dir = File.dirname(File.dirname(__FILE__))
ext_dir =  ruby_dir + '/ext/case_transform'
config = Thermite::Config.new(cargo_project_path: ext_dir, ruby_project_path: ruby_dir)
# Do I have to use fiddle? :-\
library = Fiddle.dlopen(config.ruby_extension_path)
func = Fiddle::Function.new(
  library['initialize_case_transform'],
  [], Fiddle::TYPE_VOIDP
)
func.call

module CaseTransform
  module_function

  def deep_transform_keys(hash, &block)
    result = {}
    hash.each do |key, value|
      result[yield(key)] = value.is_a?(Hash) ? value.deep_transform_keys(&block) : value
    end
    result
  end

  def transform(value, via)
    case value
    when Array then value.map { |item| send(via, item) }
    when Hash then deep_transform_keys(value) { |key| send(via, key) }
    when Symbol then send(via, value.to_s).to_sym
    when String then yield(value)
    else value
    end
  end

  # Transforms values to UpperCamelCase or PascalCase.
  #
  # @example:
  #    "some_key" => "SomeKey",
  def camel(value)
    transform(value, :camel) do |v|
      v.to_snake_case.to_class_case
    end
  end

  # Transforms values to camelCase.
  #
  # @example:
  #    "some_key" => "someKey",
  def camel_lower(value)
    transform(value, :camel_lower) do |v|
      v.to_snake_case.to_camel_case
    end
  end

  # Transforms values to dashed-case.
  # This is the default case for the JsonApi adapter.
  #
  # @example:
  #    "some_key" => "some-key",
  def dash(value)
    transform(value, :dash) do |v|
      v.to_snake_case.to_kebab_case
    end
  end

  # Transforms values to underscore_case.
  # This is the default case for deserialization in the JsonApi adapter.
  #
  # @example:
  #    "some-key" => "some_key",
  def underscore(value)
    transform(value, :underscore, &:to_snake_case)
  end

  # Returns the value unaltered
  def unaltered(value)
    value
  end
end
