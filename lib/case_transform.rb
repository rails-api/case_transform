# frozen_string_literal: true
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string'

require 'case_transform/version'

module CaseTransform
  class << self
    def camel_cache
      @camel_cache ||= {}
    end

    def camel_lower_cache
      @camel_lower_cache ||= {}
    end

    def dash_cache
      @dash_cache ||= {}
    end

    def underscore_cache
      @underscore_cache ||= {}
    end

    # Transforms values to UpperCamelCase or PascalCase.
    #
    # @example:
    #    "some_key" => "SomeKey",
    def camel(value)
      transform_helper(:camel, value) { |v| v.underscore.camelize }
    end

    # Transforms values to camelCase.
    #
    # @example:
    #    "some_key" => "someKey",
    def camel_lower(value)
      transform_helper(:camel_lower, value) { |v| v.underscore.camelize(:lower) }
    end

    # Transforms values to dashed-case.
    # This is the default case for the JsonApi adapter.
    #
    # @example:
    #    "some_key" => "some-key",
    def dash(value)
      transform_helper(:dash, value) { |v| v.underscore.dasherize }
    end

    # Transforms values to underscore_case.
    # This is the default case for deserialization in the JsonApi adapter.
    #
    # @example:
    #    "some-key" => "some_key",
    def underscore(value)
      transform_helper(:underscore, value, &:underscore)
    end

    # Returns the value unaltered
    def unaltered(value)
      value
    end

    def transform_helper(method_name, value)
      case value
      when Array then value.map { |item| send(method_name, item) }
      when Hash then value.deep_transform_keys! { |key| send(method_name, key) }
      when Symbol then send(method_name, value.to_s).to_sym
      when String then underscore_cache[value] ||= yield(value)
      else value
      end
    end
  end
end
