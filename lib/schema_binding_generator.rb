require_relative 'schema_binding'
require_relative 'schema_binding_utils'

class SchemaBinding
  def generate(object, opts = {})
    fail ArgumentError, 'object is nil' if object.nil?

    opts ||= {}
    object_schema = {}
    settings = call_bind(object) || {}
    get_properties(object).each do |property|
      property_value = object.send(property)
      property_value = property_value.clone if is_cloneable?(property_value)
      property_alias = property
      if settings.include?(property)
        binding_settings = settings[property]
        validate_property_options(binding_settings)
        property_alias = get_option(binding_settings, :alias, property)
        next if get_option(binding_settings, :ignored, false)
        if binding_settings.include?(:type)
          property_value.map!{ |x| generate(x, opts) } unless property_value.nil?
        end
      end
      object_schema[property_alias] = property_value
    end
    object_schema.reject!{ |_, value| value.nil? } if get_option(opts, :ignore_nil, true)
    object_schema
  end
end
