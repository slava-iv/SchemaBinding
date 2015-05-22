require_relative 'schema_binding'
require_relative 'schema_binding_utils'

class SchemaBinding
  def parse(object_schema, type, opts = {})
    fail ArgumentError, 'object_schema is nil' if object_schema.nil?

    opts ||= {}
    object = type.new
    settings = call_bind(object)
    get_properties(object).each do |property|
      property_alias = property
      binding_settings = nil
      if settings.include?(property)
        binding_settings = settings[property]
        property_alias = get_option(binding_settings, :alias, property)
        next if get_option(binding_settings, :ignored, false)
      end
      value = object_schema[property_alias]
      value = value.clone if is_cloneable?(value)
      unless binding_settings.nil? || !binding_settings.include?(:type)
        value.map!{ |x| parse(x, binding_settings[:type], opts) } unless value.nil?
      end
      object.send("#{property}=", value) if value.nil? || get_option(opts, :ignore_nil, true)
    end
    object
  end
end
