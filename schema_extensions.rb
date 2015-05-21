class Object
  @@_bind_values = {}

  def get_binding
    @@_bind_values
  end

  def bind_array(name)
    @@_bind_values[name] = { :array => true }
  end

  def bind_array_of(name, type)
    @@_bind_values[name] = { :array => true, :type => type }
  end

  def bind_hash(name)
    @@_bind_values[name] = { :hash => true }
  end

  def bind_hash_of(name, type)
    @@_bind_values[name] = { :hash => true, :type => type }
  end

  def bind_object(name, type)
    @@_bind_values[name] = { :type => type }
  end

  def bind_ignore(name)
    @@_bind_values[name] = { :ignore => true }
  end
end