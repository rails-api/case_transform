# frozen_string_literal: true

module CaseTransform2
  # String class extension
  # Stolen from ActiveSupport::Inflector.camelize
  # @api private
  class StringExt
    def camelize(string, first_letter = :upper)
      raise ArgumentError, 'Argument can not be nil' unless %i[upper lower].include?(first_letter)

      str = string.to_s
      str = str.gsub(/^[a-z\d]*/, &:capitalize) if first_letter == :upper
      str.gsub(%r{(?:_|(/))([a-z\d]*)}i) do
        "#{Regexp.last_match(1)}#{Regexp.last_match(2).capitalize}"
      end.gsub('/', '::')
    end

    def dasherize(string)
      string.tr('_', '-')
    end

    # Only support camel to underscore
    def underscore(string)
      str = string.to_s
      return str unless str =~ /[A-Z-]|::/

      str.gsub('::', '/')
         .gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
         .gsub(/([a-z\d])([A-Z])/, '\1_\2')
         .tr('-', '_')
         .downcase
    end
  end
end
