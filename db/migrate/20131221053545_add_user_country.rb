class AddUserCountry < ActiveRecord::Migration
  def change
  	add_column :tickets, :country, :string
  end
end
