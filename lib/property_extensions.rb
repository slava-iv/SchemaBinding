class SchemaBinding
  class PropertyExtensions
    attr_reader :owner

    attr_reader :property

    def initialize(owner, property)
      @owner = owner
      @property = property
    end

    def set_required(value = true)
      owner.get_binding[property][:required] = value
      self
    end

    def set_ignored(value = true)
      owner.get_binding[property][:ignored] = value
      self
    end

    def set_alias(alias_name)
      owner.get_binding[property][:alias] = alias_name
      self
    end
  end
end