$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)


require 'test_helper'
require 'exponential_backoff.rb'


describe "ExponentialBackOffTest" do

  describe "verify_input" do

    before do
      set_default_backoff_object
    end

    def set_default_backoff_object

      url = "https://httpbin.org/delay/3"
      max_retries = 4
      initial_delay = 1
      delay_multiplier = 2

      @exponential_backoff =  ExponentialBackOff.new(url,max_retries, initial_delay, delay_multiplier);
    
    end

    it 'Should raise ArgumentError if url is in a invalid format' do
      
      @exponential_backoff.url = "invlaidurl..com"

      proc { @exponential_backoff.start() }.must_raise ArgumentError
    
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

  describe "request_url_with_timeout" do

    before do
      @exponential_backoff = ExponentialBackOff.new("https://httpbin.org/delay/3",4,1,2);
    end

    it 'Should raise Timeout::Error error if request is not completed in the time specified' do
      
      url = "https://httpbin.org/delay/3"

      delayInSeconds = 1

      proc {  @exponential_backoff.request_url_with_timeout(url,delayInSeconds) }.must_raise Timeout::Error

    end

    it 'Should raise Timeout::Error error if request does not return success status code' do
      
      url = "https://httpbin.org/status/400"

      delayInSeconds = 1

      proc {  @exponential_backoff.request_url_with_timeout(url,delayInSeconds) }.must_raise OpenURI::HTTPError

    end
    
  end

end
