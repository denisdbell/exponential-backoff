$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "exponential_backoff.rb"



ExponentialBackOff.new().start(1,2);

