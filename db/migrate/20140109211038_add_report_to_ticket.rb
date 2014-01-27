class AddReportToTicket < ActiveRecord::Migration
	def change
  		add_column :tickets, :reporter_id, :integer
  	end
end
