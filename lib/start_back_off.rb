$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "exponential_backoff.rb"

url = (!ARGV[0].nil? && !ARGV[0].empty?) ? ARGV[0] : "https://httpbin.org/delay/3" 
max_retries = (!ARGV[1].nil? && !ARGV[1].empty?)  ? ARGV[1].to_i : 3
initial_delay = (!ARGV[2].nil? && !ARGV[2].empty?) ? ARGV[2].to_i : 1
delay_multiplier = (!ARGV[3].nil? && !ARGV[3].empty?) ? ARGV[3].to_i : 2

ExponentialBackOff.new(url,max_retries,initial_delay,delay_multiplier).start();