class AlterTicketTicketPhoneNumber < ActiveRecord::Migration
  def change
  	change_column :tickets, :phone_number, :string
  end
end
