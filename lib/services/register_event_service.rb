require 'id_generator'
require 'models/event'
require 'rddd/service'

class RegisterEventService < Rddd::Service
  def execute
    event = Event.new(IdGenerator.build)

    event.time = Time.now
    [:name, :user, :params].each do |attribute|
      event.send :"#{attribute}=", @attributes[attribute]
    end

    event.create
  end
end