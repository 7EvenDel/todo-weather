# == Schema Information
#
# Table name: weather
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  city                   :string           not null
#  precipitation          :bigint          
#  weather_code           :bigint


class Weather < ApplicationRecord
    validates :temperature, :precipitation, :weather_code, :city, presence: true
    has_many :tasks
end
