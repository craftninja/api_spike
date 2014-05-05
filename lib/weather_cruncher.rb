require 'faraday'
require 'json'

class WeatherCruncher

  def initialize
    @weather_connection = Faraday.new(:url => 'http://api.openweathermap.org/') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
  end

  def current_weather(city)
    response = @weather_connection.get "http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=imperial"
    data = JSON.parse(response.body)
    current_temp = data['main']['temp']
    max_temp = data['main']['temp_min']
    min_temp = data['main']['temp_max']
    sky_condition = data['weather'].first['main']
    wind_speed = data['wind']['speed']
    current_weather = "Current weather in #{city}: "
    current_weather += "skies are #{sky_condition.downcase}, "
    current_weather += "current temperature is #{current_temp}, "
    current_weather += "wind speed is #{wind_speed}. "
    current_weather += "Expect today's temperatures to range from #{min_temp} to #{max_temp}"
  end

end
