class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      
      t.string :title, :null => false, :default => 	""
      t.text :description

      #customer info
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :province
      t.string :postalcode
      t.boolean :address_confirm

      #receive info
      t.belongs_to :user
      t.string :receive_from
      t.string :last_contacted_customer

      #defines the date time 
      t.datetime :date_in
      t.datetime :date_due
      t.datetime :date_ready
      t.datetime :date_out

      #shipping info
      t.string :shipping_service
      t.string :shipping_date
      t.string :tracking_number

      #1 means active 
      #2 means open
      #3 means progress
      #4 means closed
      #5 means cancel
      t.String :status 
 
      t.timestamps

      
    end
  end
end
