require 'spec_helper'
require 'models/event'
require 'rddd/aggregate_root'

describe Event do
  it { should have_finder(:all).to(EventRepository) }

  it { should have_finder(:by_name).to(EventRepository) }
    
  it { should have_finder(:by_user).to(EventRepository) }

  describe 'Event' do
    subject { Event }

    it { subject.ancestors.should include(Rddd::AggregateRoot) }
  end

  let(:id) { stub('id') }

  subject { Event.new(id) }

  it { should have_accessor :name }

  it { should have_accessor :user }

  it { should have_accessor :time }

  it { should have_accessor :params }
end