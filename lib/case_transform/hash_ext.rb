module CaseTransform
  class HashExt
    def deep_transform_keys!(object, &block)
      _deep_transform_keys_in_object!(object, &block)
    end

    private

    def _deep_transform_keys_in_object!(object, &block)
      case object
      when Hash
        object.keys.each do |key|
          value = object.delete(key)
          object[yield(key)] = _deep_transform_keys_in_object!(value, &block)
        end
        object
      when Array
        object.map! { |e| _deep_transform_keys_in_object!(e, &block) }
      else
        object
      end
    end
  end
end
