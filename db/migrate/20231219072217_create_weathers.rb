class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.float :temperature
      t.float :precipitation
      t.string :weather_code
      t.string :city

      t.timestamps
    end
  end
end
