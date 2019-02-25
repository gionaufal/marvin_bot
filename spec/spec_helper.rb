require "lita/rspec"
Lita.version_3_compatibility_mode = false

# needed for running with docker
Lita.configure do |config|
  config.redis[:host] = 'redis'
end
