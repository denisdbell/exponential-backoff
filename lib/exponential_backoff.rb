require 'open-uri'
require 'timeout'
require 'uri'

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
    
      verify_input

    begin

      request_url_with_timeout(@@url,@@current_delay)

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

  def verify_input

    raise ArgumentError, 'Value of url is not valid. Format should be like the folllowing http://www.example.com' unless @@url =~ URI::regexp  

    raise ArgumentError, 'Value of number of retries cannot be negative. Valid values are postive integers between 0 to N' unless @@max_retries >= 0  
		
    raise ArgumentError, 'Value of initial delay cannot be negative. Valid values are positive  integers between 1 to N' unless @@initial_delay >= 0
		
		raise ArgumentError, 'Value of number of retries is not numeric. Valid values are postive integers between 0 to N' unless @@max_retries.is_a? Numeric  
	   	
	  raise ArgumentError, 'Value of initial delay is not numeric. Valid values are postive integers between 1 to N' unless @@initial_delay.is_a? Numeric       

  end

  def request_url_with_timeout(url,delay)

    status = ""

    response = Timeout::timeout(delay) {
      open(url) do |f|
        status = f.status
      end
    }

    #Return response only if there is a 2XX or success status code 
    if status[0].to_i >= 200 && status[0].to_i < 300
    
      return response
    
    else
      
      raise "Url request failed. Status code of: #{status[0].to_i } returned"
    
    end

  end

  #Getters and Setters
  def url=(url)
    @@url = url
  end

  def response
    @@response
  end


  def response=(response)
    @@response = response
  end

  def response
    @@response
  end

  def max_retries
    @@max_retries
  end

  def max_retries=(max_retries)
    @@max_retries = max_retries
  end

  def initial_delay
    @@max_retries
  end

  def initial_delay=(initial_delay)
    @@initial_delay = initial_delay
  end

  def current_delay
    @@current_delay
  end

  def current_delay=(current_delay)
    @@current_delay = current_delay
  end

  def delay_multiplier
    @@delay_multiplier
  end

  def delay_multiplier=(delay_multiplier)
    @@delay_multiplier = delay_multiplier
  end

  def current_retries
    @@current_retries
  end

  def current_retries=(current_retries)
    @@current_retries = current_retries
  end

  def delay_multiplier
    @@delay_multiplier
  end

  def delay_multiplier=(delay_multiplier)
    @@delay_multiplier = delay_multiplier
  end
  
end
