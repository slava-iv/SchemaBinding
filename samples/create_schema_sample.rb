require_relative '../lib/schema_binding'

class Test
  attr_accessor :property

  attr_accessor :some

  attr_accessor :nested_objects

  attr_accessor :nil_property

  attr_accessor :private_property

  def binding
    bind_array(:some){ |p| p.set_alias('SomeBindingName').set_ignored(false) }
    bind_array_of(:nested_objects, Test)
    bind_ignored(:private_property)
  end

  def initialize(nested_objects = nil)
    @property = rand 10
    @nested_objects = nested_objects
    @some = [rand(10), rand(10)]
    @private_property = 'this is ignoring'
  end
end

value = Test.new([Test.new, Test.new, Test.new])

schema = value.to_schema
schema_new = Test.from_schema(schema).to_schema

puts "generated result: #{schema}"
puts "parsed result:    #{schema_new}"