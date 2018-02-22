$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)


require 'test_helper'
require 'exponential_backoff.rb'


describe "ExponentialBackOffTest" do

  before do
    @exponential_backoff = ExponentialBackOff.new("https://httpbin.org/delay/3",4,1,2);
  end

  it 'Should raise ArgumentError if max_retries is negative' do
    
    @exponential_backoff.max_retries = -1

    proc { @exponential_backoff.start() }.must_raise ArgumentError
  
  end

  it 'Should raise ArgumentError if initial_delay is negative' do
    
    @exponential_backoff.initial_delay = -1
    
    proc { @exponential_backoff.start() }.must_raise ArgumentError
  
  end

  it 'Should raise ArgumentError if max_retries not numeric' do

    @exponential_backoff.max_retries = "a"

    proc {  @exponential_backoff.start() }.must_raise ArgumentError

  end

  it 'Should raise argument error if initial_delay is not numeric' do

    @exponential_backoff.initial_delay = "a"

    proc {  @exponential_backoff.start() }.must_raise ArgumentError

  end

end
