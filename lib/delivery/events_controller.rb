require 'services/register_event_service'

class EventsController < Sinatra::Base
  post '/register_event' do
    RegisterEventService.new(params[:event]).execute
  end
end