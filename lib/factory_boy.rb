module FactoryBoy
  attr_reader :factories
  @factories = {}
  def self.define(&block)
    module_eval(&block)
  end
  def self.build(klass)
    instance = const_get(@factories[klass].class_name.capitalize).new
    @factories[klass].our_methods.each do |key, value|
      instance.class.class_eval do
        define_method(key.to_sym) { value }
      end
    end
    instance
  end
  def self.factory(klass, &block)
    instance = @factories[klass] = BaseObject.new(klass.to_s.capitalize)
    instance.instance_eval(&block)
  end
  class BaseObject < BasicObject
    attr_accessor :our_methods, :class_name

    def initialize(klass)
      @our_methods = {}
      @class_name = klass.to_s 
    end
    def method_missing(method, *args, &block)
      @our_methods[method] = args.first || block
    end
  end
end
