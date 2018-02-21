$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)


require 'test_helper'
require 'exponential_backoff.rb'


describe "ExponentialBackOffTest" do

  before do
    @exponential_backoff = ExponentialBackOff.new
  end

  it 'Should raise ArgumentError if number_of_retries is negative' do
    
    number_of_retries = -1
		initial_delay = 3

    proc {  @exponential_backoff.start(number_of_retries,initial_delay) }.must_raise ArgumentError
  
  end

  it 'Should raise ArgumentError if initial_delay is negative' do
    
    number_of_retries = 3
		initial_delay = -1

    proc {  @exponential_backoff.start(number_of_retries,initial_delay) }.must_raise ArgumentError
  
  end

  it 'Should raise ArgumentError if number_of_retries_is not numeric' do

    number_of_retries = "a"
		initial_delay = 3

    proc {  @exponential_backoff.start(number_of_retries,initial_delay) }.must_raise ArgumentError

  end

  it 'Should raise argument error if initial_delay is not numeric' do

    number_of_retries = 3
    initial_delay = "b"

    proc {  @exponential_backoff.start(number_of_retries,initial_delay) }.must_raise ArgumentError

  end

end
