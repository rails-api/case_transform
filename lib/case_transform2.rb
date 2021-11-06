# frozen_string_literal: true

require 'case_transform2/hash_ext'
require 'case_transform2/string_ext'
require 'case_transform2/version'

module CaseTransform2
  class << self
    # Transforms values to UpperCamelCase or PascalCase.
    #
    # @example
    #    "some_key" => "SomeKey",
    def camel(value)
      case value
      when Array
        value.map { |item| camel(item) }
      when Hash
        hash_ext.deep_transform_keys!(value) { |key| camel(key) }
      when Symbol
        camel(value.to_s).to_sym
      when String
        camel_cache[value] ||= string_ext.camelize(string_ext.underscore(value))
      else
        value
      end
    end

    # Transforms values to camelCase.
    #
    # @example
    #    "some_key" => "someKey",
    def camel_lower(value)
      case value
      when Array
        value.map { |item| camel_lower(item) }
      when Hash
        hash_ext.deep_transform_keys!(value) { |key| camel_lower(key) }
      when Symbol
        camel_lower(value.to_s).to_sym
      when String
        camel_lower_cache[value] ||= string_ext.camelize(string_ext.underscore(value), :lower)
      else
        value
      end
    end

    # Transforms values to dashed-case.
    #
    # @example
    #    "some_key" => "some-key",
    def dash(value)
      case value
      when Array
        value.map { |item| dash(item) }
      when Hash
        hash_ext.deep_transform_keys!(value) { |key| dash(key) }
      when Symbol
        dash(value.to_s).to_sym
      when String
        dash_cache[value] ||= string_ext.dasherize(string_ext.underscore(value))
      else
        value
      end
    end

    # Transforms values to underscore_case.
    #
    # @example
    #    "some-key" => "some_key",
    def underscore(value)
      case value
      when Array
        value.map { |item| underscore(item) }
      when Hash
        hash_ext.deep_transform_keys!(value) { |key| underscore(key) }
      when Symbol
        underscore(value.to_s).to_sym
      when String
        underscore_cache[value] ||= string_ext.underscore(value)
      else
        value
      end
    end

    private

    def string_ext
      @string_ext ||= CaseTransform2::StringExt.new
    end

    def hash_ext
      @hash_ext ||= CaseTransform2::HashExt.new
    end

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
  end
end
