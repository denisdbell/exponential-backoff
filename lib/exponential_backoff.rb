require 'open-uri'
require 'timeout'

class ExponentialBackOff

  @@url = ""
  @@response = ""
  @@max_retries = 0
  @@initial_delay = 0
  @@current_delay = 0
  @@current_retries = 0
  @@delay_multiplier = 0

  def initialize(url,max_retries, initial_delay, delay_multiplier)
      @@url = url  
      @@max_retries = max_retries
      @@initial_delay = initial_delay
      @@delay_multiplier = delay_multiplier
      @@current_delay = @@initial_delay
  end
  
  def start() 
    
		raise ArgumentError, 'Value of number of retries cannot be negative. Valid values are postive integers between 0 to N' unless @@max_retries >= 0  
		
    raise ArgumentError, 'Value Of Initial delay cannot be negative. Valid values are positive  integers between 1 to N' unless @@initial_delay >= 0
		
		raise ArgumentError, 'Value of number of retries is not numeric. Valid values are postive integers between 0 to N' unless @@max_retries.is_a? Numeric  
	   	
	  raise ArgumentError, 'Value of initial delay is not numeric. Valid values are postive integers between 1 to N' unless @@initial_delay.is_a? Numeric       

    begin

      @@response = Timeout::timeout(@@current_delay) {
        open(@@url).read
      }

    rescue Timeout::Error => e

      if  @@current_retries <= @@max_retries
          @@current_retries += 1
          @@current_delay =  @@current_delay * @@delay_multiplier
          puts @@current_delay
          retry
      else
        raise "Timeout: #{e.message}"
      end
    end
    
  end
  
end
