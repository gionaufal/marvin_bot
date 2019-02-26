module Lita
  module Handlers
    class Weather < Handler
      route(/weather/, :weather, command: false)

      def weather(response)
        weather_now ||=
          http.get("http://apiadvisor.climatempo.com.br/api/v1/weather/locale/#{ENV['CLIMATEMPO_CITY_ID']}/current?token=#{ENV['CLIMATEMPO_TOKEN']}")
              .yield_self { |http_response| MultiJson.load(http_response.body) }

        temperature = weather_now.dig('data', 'temperature')
        sensation = weather_now.dig('data', 'sensation')
        condition = weather_now.dig('data', 'condition')

        response.reply("Agora faz #{condition}, a temperatura é de #{temperature}°C com sensação de #{sensation}°C")

        forecasts ||=
          http.get("http://apiadvisor.climatempo.com.br/api/v1/forecast/locale/#{ENV['CLIMATEMPO_CITY_ID']}/days/15?token=#{ENV['CLIMATEMPO_TOKEN']}")
              .yield_self { |http_response| MultiJson.load(http_response.body) }

        forecast_for_today = forecasts.fetch('data').first
        forecast_for_tomorrow = forecasts.fetch('data')[1]

        forecast_for(forecast_for_today, response)
        response.reply('Amanhã:')
        forecast_for(forecast_for_tomorrow, response)
      end

      Lita.register_handler(self)

      private

        def forecast_for(forecast, response)
          date = forecast.fetch('date_br')
          max = forecast.dig('temperature', 'max')
          min = forecast.dig('temperature', 'min')
          rain = forecast.dig('rain', 'probability')
          phrase = forecast.dig('text_icon','text', 'phrase', 'reduced')

          response.reply("Essa é a previsão para #{date}")
          response.reply(phrase)
          response.reply("Máxima de #{max}°C e mínima de #{min}°C, com #{rain}% de chance de chuva")
        end
    end
  end
end
