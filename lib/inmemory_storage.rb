require 'json'
require 'couchrest'
require 'singleton'
require 'configuration'

class InMemoryStrages
  include Singleton

  def self.build(name)
    @list ||= {}

    @list[name] ||= InMemoryStorage.new(name)

    @list[name]
  end
end

class InMemoryStorage
  attr_reader :name
  
  def initialize(name)
    @name = name
    @keys = {}
  end

  def get(key)
    @keys[key]
  end

  def set(key, object)
    @keys[key] = object
  end

  def delete(key)
    @keys.delete key
  end

  def get_list(key)
    @keys[key] || []
  end

  def add_to_list(key, object)
    @keys[key] ||= []
    @keys[key] << object
  end

  def remove_from_list(key, object)
    @keys.delete(object)
  end

  def clear
    @keys = {}
  end
end
