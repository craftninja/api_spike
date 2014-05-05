require 'faraday'
require 'json'
require 'time'

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
    current_weather += "atmospheric condition: #{sky_condition.downcase}, "
    current_weather += "current temperature: #{current_temp}, "
    current_weather += "wind speed: #{wind_speed}. "
    current_weather += "Expect today's temperatures to range from #{min_temp} to #{max_temp}"
  end

  def forcast_7_day(city)
    forcast_7_day = ''
    response = @weather_connection.get "http://api.openweathermap.org/data/2.5/forecast/daily?q=#{city}&units=imperial&cnt=7"
    seven_day_data = JSON.parse(response.body)
    seven_day_data['list'].each do |day_data|
      day = Time.at(day_data['dt']).strftime('%A')
      day_temp = day_data['temp']['day']
      max_temp = day_data['temp']['min']
      min_temp = day_data['temp']['max']
      sky_condition = day_data['weather'].first['main']
      wind_speed = day_data['speed']
      current_weather = "#{day} weather in #{city}: "
      current_weather += "atmospheric condition: #{sky_condition.downcase}, "
      current_weather += "day temperature: #{day_temp}, "
      current_weather += "wind speed: #{wind_speed}. "
      current_weather += "Expect #{day}'s temperatures to range from #{min_temp} to #{max_temp}."
      forcast_7_day += current_weather
    end
    forcast_7_day
  end

end
