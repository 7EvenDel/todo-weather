class WeatherController < ApplicationController
  require 'httparty'

  def select_city
    # Replace these with your actual city names
    @cities = ['Kyiv', 'Lviv', 'Ternopil']
  end

  def get_weather
    city = params[:city]

    response = HTTParty.get("https://api.tomorrow.io/v4/timelines", 
      query: {
        location: city,
        apikey: 'yb323QFeeykkC0GQtySmgv2Jv94GDwVs',
        fields: 'temperature_2m,precipitation_1h,weathercode'
      }
    )

    if response.code == 200
      weather_data = response.parsed_response['data']['timelines'].first['intervals'].first
      @weather = Weather.new(
        temperature: weather_data['values']['temperature_2m'],
        precipitation: weather_data['values']['precipitation_1h'],
        weather_code: weather_data['values']['weathercode'],
        city: city
      )

      if @weather.save
        redirect_to weather_get_weather_path(city: city)
      else
        flash[:error] = "Error saving weather data"
        redirect_to weather_select_city_path
      end
    else
      flash[:error] = "Error fetching weather data: #{response.code}"
      redirect_to weather_select_city_path
    end
  end
end
