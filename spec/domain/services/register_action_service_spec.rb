require 'spec_helper'
require 'services/register_event_service'

describe RegisterEventService do
  let(:service) { RegisterEventService.new(attributes) }

  let(:event) { stub('event') }

  let(:time) { stub('time') }

  subject { service.execute }

  let(:user) { stub('user') }

  let(:params) { stub('params') }

  let(:attributes) do
    {
      :name => :account_created,
      :user => user,
      :params => params
    }
  end

  let(:id) { stub('id') }

  before do
    IdGenerator.expects(:build).returns(id)

    Event.expects(:new).with(id).returns(event)

    event.expects(:name=).with(:account_created)

    Time.expects(:now).returns(time)
    event.expects(:time=).with(time)
    event.expects(:user=).with(user)
    event.expects(:params=).with(params)
    event.expects(:create)
  end

  it { should_not be}
end