class WeatherApi
  def self.get_weather(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query="
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    temperature = response.parsed_response["current"]["temperature"]
    weather_icons = response.parsed_response["current"]["weather_icons"][0]
    wind_speed = response.parsed_response["current"]["wind_speed"]
    wind_dir = response.parsed_response["current"]["wind_dir"]
    [temperature, weather_icons, wind_speed, wind_dir]
  end

  def self.key
    return nil if Rails.env.test?
    raise 'WEATHER_APIKEY env variable not defined' if ENV['WEATHER_APIKEY'].nil?

    ENV.fetch('WEATHER_APIKEY')
  end
end
