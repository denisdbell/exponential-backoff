$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "exponential_backoff.rb"

ExponentialBackOff.new("https://httpbin.org/delay/3",4,1,2).start();

