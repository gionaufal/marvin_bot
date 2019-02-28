require './handlers/hello_lita'
require './handlers/weather'

require 'dotenv/load'

Lita.configure do |config|
  config.robot.name = "Marvin"

  config.robot.log_level = :info

  config.robot.adapter = :telegram_plus
  config.adapters.telegram_plus.token = ENV['TELEGRAM_TOKEN']

  if ENV["REDISTOGO_URL"]
    config.redis[:url] = ENV["REDISTOGO_URL"]
  else
    config.redis[:host] = "redis"
  end

  if ENV["PORT"]
    config.http.port = ENV["PORT"]
  end
end
