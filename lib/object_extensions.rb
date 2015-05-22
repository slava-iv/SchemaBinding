class Object
  def get_binding
    @@__BIND_VALUES__ if defined?(@@__BIND_VALUES__)
  end

  def clear_binding
    @@__BIND_VALUES__ = nil
  end

  def set_bind(name, key, value)
    @@__BIND_VALUES__ ||= {}
    @@__BIND_VALUES__[name] ||= {}
    @@__BIND_VALUES__[name][key] = value
  end

  def bind_type(name, type)
    set_bind(name, :type, type)
    yield SchemaBinding::PropertyExtensions.new(self, name) if defined?(yield)
    self
  end

  def bind_array(name)
    set_bind(name, :array, true)
    yield SchemaBinding::PropertyExtensions.new(self, name) if defined?(yield)
    self
  end

  def bind_array_of(name, type)
    set_bind(name, :array, true)
    set_bind(name, :type, type)
    yield SchemaBinding::PropertyExtensions.new(self, name) if defined?(yield)
    self
  end

  def bind_hash(name)
    set_bind(name, :hash, true)
    yield SchemaBinding::PropertyExtensions.new(self, name) if defined?(yield)
    self
  end

  def bind_hash_of(name, type)
    set_bind(name, :hash, true)
    set_bind(name, :type, type)
    yield SchemaBinding::PropertyExtensions.new(self, name) if defined?(yield)
    self
  end

  def bind_required(name, value = true)
    set_bind(name, :required, value)
    yield SchemaBinding::PropertyExtensions.new(self, name) if defined?(yield)
    self
  end

  def bind_ignored(name, value = true)
    set_bind(name, :ignored, value)
    yield SchemaBinding::PropertyExtensions.new(self, name) if defined?(yield)
    self
  end

  def bind_alias(name, schema_name)
    set_bind(name, :alias, schema_name)
    yield SchemaBinding::PropertyExtensions.new(self, name) if defined?(yield)
    self
  end
end
