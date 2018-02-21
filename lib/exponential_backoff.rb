#require "exponential_backoff/version"
require 'securerandom'
require 'open-uri'
require 'timeout'

class ExponentialBackOff
  
  def start(url,number_of_retries,initial_delay) 
    
    retries = 0
    delay = 1

		raise ArgumentError, 'Value of number of retries cannot be negative. Valid values are postive integers between 0 to N' unless number_of_retries >= 0  
		
    raise ArgumentError, 'Value Of Initial delay cannot be negative. Valid values are positive  integers between 1 to N' unless initial_delay >= 0
		
		raise ArgumentError, 'Value of number of retries is not numeric. Valid values are postive integers between 0 to N' unless number_of_retries.is_a? Numeric  
	   	
	  raise ArgumentError, 'Value of initial delay is not numeric. Valid values are postive integers between 1 to N' unless initial_delay.is_a? Numeric       

    begin

      response = Timeout::timeout(delay) {
        open(url).read
      }
      
      puts response

      if response.nil?
        puts "There is no object"
      end

    rescue Timeout::Error => e

      if retries <= number_of_retries
        retries += 1
        delay = delay * 2

        puts delay
        retry
      else
        raise "Timeout: #{e.message}"
      end
    end


  end
  
end
