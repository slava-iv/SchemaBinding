require_relative 'schema_binding'

class Test
  attr_accessor :property

  attr_accessor :some

  attr_accessor :childs

  attr_accessor :private

  def binding
    bind_array(:some)
    bind_array_of(:childs, Test)
    bind_ignore(:private)
  end

  def initialize(childs = nil)
    @property = rand 10
    @childs = childs
    @some = [rand(10), rand(10)]
    @private = 'this is ignoring'
  end
end

value = Test.new([Test.new, Test.new, Test.new])
puts SchemaBinding::generate_json(value, :ignore_nil => false)