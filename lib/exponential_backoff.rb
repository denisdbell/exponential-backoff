require "exponential_backoff/version"

class ExponentialBackOff
  
	def start(number_of_retries,initial_delay) 		

		raise ArgumentError, 'Value of number of retries cannot be negative. Valid values are postive integers between 0 to N' unless number_of_retries >= 0  
		
    raise ArgumentError, 'Value Of Initial delay cannot be negative. Valid values are positive  integers between 1 to N' unless initial_delay >= 0
		
		raise ArgumentError, 'Value of number of retries is not numeric. Valid values are postive integers between 0 to N' unless number_of_retries.is_a? Numeric  
	   	
	  raise ArgumentError, 'Value of initial delay is not numeric. Valid values are postive integers between 1 to N' unless initial_delay.is_a? Numeric       

  end
  
end
