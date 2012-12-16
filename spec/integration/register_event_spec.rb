require 'spec_helper'
require 'sinatra'
require 'rack/test'
require 'delivery/events_controller'

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  EventsController
end

describe EventsController do
  include Rack::Test::Methods

  before do
  end

  describe 'POST /' do
    subject { last_response }

    let(:event) do
      {
        :name => 'user_created',
        :user => 'petr@ngneers.com',
        :params => {:foo => 'bar'}
      }
    end

    before { post '/register_event', :event => event }

    it { should be_ok }

    describe 'event' do
      subject { Event.all.last }

      its(:name) { should == :user_created }

      its(:user) { should == 'petr@ngneers.com' }

      its(:params) { should == {'foo' => 'bar'} }
    end
  end
end