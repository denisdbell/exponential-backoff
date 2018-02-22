$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)


require 'test_helper'
require 'exponential_backoff.rb'


describe "ExponentialBackOffTest" do

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

  describe "verify_input" do

    it 'Should raise ArgumentError if url is blank' do
      
      @exponential_backoff.url = ""

      proc { @exponential_backoff.start() }.must_raise ArgumentError
    
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

    it 'Should return a response if request has status code of 200 and delay is not exceeded' do
      
      url = "https://httpbin.org/delay/3"

      delayInSeconds = 4

      @exponential_backoff.request_url_with_timeout(url,delayInSeconds).wont_be_empty
    end
    
  end

  describe "generate_delay" do

    it 'Should raise ArgumentError if current_delay is negative' do
      
      current_delay = -1
      delay_multiplier = 2

      proc {  @exponential_backoff.generate_delay(current_delay,delay_multiplier) }.must_raise ArgumentError

    end

    it 'Should raise ArgumentError if current_delay is not numeric' do
      
      current_delay = "a"
      delay_multiplier = 2

      proc {  @exponential_backoff.generate_delay(current_delay,delay_multiplier) }.must_raise ArgumentError

    end

    it 'Should raise ArgumentError if delay_multiplier is negative' do
      
      current_delay = 1
      delay_multiplier = -1

      proc {  @exponential_backoff.generate_delay(current_delay,delay_multiplier) }.must_raise ArgumentError

    end

    it 'Should raise ArgumentError if delay_multiplier is not numeric' do
      
      current_delay = 1
      delay_multiplier = "a"

      proc {  @exponential_backoff.generate_delay(current_delay,delay_multiplier) }.must_raise ArgumentError

    end


    it 'Should return the product of current_delay and  delay_multiplier' do
      
      current_delay = 1
      delay_multiplier = 3

      product = current_delay * delay_multiplier

      @exponential_backoff.generate_delay(current_delay,delay_multiplier).must_equal product

    end


  end

end
