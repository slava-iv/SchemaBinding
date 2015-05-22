require 'json'
require_relative 'object_extensions'
require_relative 'property_extensions'
require_relative 'schema_binding_generator'
require_relative 'schema_binding_parser'

class Object
  def to_schema(opts = {})
    SchemaBinding::generate(self, opts)
  end

  def self.from_schema(object, opts = {})
    SchemaBinding::parse(object, self, opts)
  end
end

class SchemaBinding
  def self.generate(object, opts = {})
    SchemaBinding.new.generate(object, opts)
  end

  def self.parse(object_schema, type, opts = {})
    SchemaBinding.new.parse(object_schema, type, opts)
  end

  def self.generate_json(value, opts = {}, json_opts = nil)
    JSON.generate(SchemaBinding.generate(value, opts), json_opts)
  end

  def self.parse_json(value, opts = {}, json_opts = {})
    JSON.parse(SchemaBinding.parse(value, opts), json_opts)
  end
end



