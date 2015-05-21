require 'json'
require_relative 'schema_extensions'

class SchemaBinding
  def self.generate_json(value, opts = {}, json_opts = nil)
    JSON.generate(SchemaBinding.generate(value, opts))
  end

  def self.generate(value, opts = {})
    object = {}
    value.binding if defined?(value.binding)
    bindingSet = value.get_binding if defined?(value.get_binding)
    properties = (value.class.instance_methods - Object.methods).grep(/^\w+=$/)
    properties.map! { |x| x.to_s.gsub('=', '').to_sym }
    properties.each do |property|
      property_value = value.send(property)
      if !bindingSet.nil? && bindingSet.include?(property)
        bindingSettings = bindingSet[property]
        next if bindingSettings.include?(:ignore) && bindingSettings[:ignore]

        if bindingSettings.include?(:type)
          property_value.map!{ |x| generate(x, opts) } unless property_value.nil?
        end
      end
      object[property] = property_value
    end
    object.reject!{ |key, value| value.nil? } if !opts.include?(:ignore_nil) || opts[:ignore_nil]
    object
  end

  def self.parse_json(value, opts = {}, json_opts = {})
    JSON.parse(SchemaBinding.parse(value, opts), json_opts)
  end

  def self.parse(value, opts = {})
    # TODO
  end
end



