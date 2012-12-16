ENV['RACK_ENV'] = 'test'

dir = "#{File.dirname(__FILE__)}/../lib/"
$LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)

require 'rack/test'
require 'core_ext/string'
require 'inmemory_storage'
require 'storage'
require 'rddd'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.mock_framework = :mocha
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :progress # :progress, :html, :textmate

  config.before(:each) do
    Storage.instance.strategy = InMemoryStrages
  end

  config.after(:each) do
    Storage.instance.build('monitor').clear
  end
end

RSpec::Matchers.define :have_finder do |method|
  chain :to do |target|
    @target = target
  end

  match do |subject|
    @target.any_instance.expects(method).with(1)
    subject.class.send(method, 1)

    true
  end
end


RSpec::Matchers.define :have_accessor do |method|
  match do |subject|
    subject.respond_to?(method) && \
    subject.respond_to?("#{method}=")
  end
end

def stub_as(responder_class, methods = {})
  responder = create_responder(responder_class)
  stub(responder_class.name.to_s, methods).responds_like(responder)
end

def create_responder(responder_class)
  list = case responder_class.name
  when 'Event' then []

  else raise "Responder '#{responder_class.name}' not defined yet!"
  end

  responder_class.new(*create_args(list))
end

def create_args(list)
  list.map {|arg| stub(arg.to_s) }
end