require 'storage'
require 'rddd/aggregate_root'

class Event < Rddd::AggregateRoot
  attr_accessor :name, :user, :time, :params

  finder :all
  finder :by_name
  finder :by_user
end

class EventFactory
  def self.build(attrs)
    Event.new(attrs[:id]).tap do |event|
      event.name = attrs[:name]
      event.user = attrs[:user]
      event.time = attrs[:time]
      event.params = attrs[:params]
    end
  end
end

class EventRepository
  def db
    @db ||= Storage.instance.build('monitor')
  end

  def create(event)
    event_id = event.id

    update(event)
    db.add_to_list("events", event_id)
    db.add_to_list("events-#{event.name}", event_id)
    db.add_to_list("user-events-#{event.user}", event_id)
  end

  def all
    db.get_list('events').map do |item|
      find(item)
    end
  end

  def by_name(name)
    db.get_list("events-#{name}").map do |item|
      find(item)
    end
  end

  def by_user(user)
    db.get_list("events-#{user}").map do |item|
      find(item)
    end
  end

  def find(id)
    EventFactory.build(db.get(id))
  end

  def update(event)
    attrs = {
      :id => event.id,
      :name => event.name.to_sym,
      :user => event.user,
      :time => event.time,
      :params => event.params
    }

    event_id = event.id

    db.set(event_id, attrs)
  end
end