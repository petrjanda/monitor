require 'singleton'

class Storage
  include Singleton

  def strategy
    @strategy
  end

  def strategy=(strategy)
    @strategy = strategy
  end

  def build(db)
    strategy.build(db)
  end
end