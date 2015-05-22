class SchemaBinding
  def get_properties(object)
    properties = (object.class.instance_methods - Object.methods).grep(/^\w+=$/)
    properties.map { |x| x.to_s.gsub('=', '').to_sym }
  end

  def call_bind(object)
    object.clear_binding if defined?(object.clear_binding)
    object.binding if defined?(object.binding)
    object.get_binding if defined?(object.get_binding)
  end

  def option_is_true?(opts, key)
    get_option(opts, key, false)
  end

  def option_is_false?(opts, key)
    get_option(opts, key, true)
  end

  def get_option(opts, key, default = nil)
    (opts.include?(key) && !opts[key].nil?) ? opts[key] : default
  end

  def validate_property_options(opts)
    fail ArgumentError, 'property can\'t be required and ignored' if option_is_true?(opts, :required) && option_is_true?(opts, :ignored)
  end

  def is_cloneable?(object)
    %w(array hash).include?(object.class.to_s.downcase)
  end
end
