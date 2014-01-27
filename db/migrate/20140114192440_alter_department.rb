class AlterDepartment < ActiveRecord::Migration
    def change
  		add_column :tickets, :department_id, :integer

  		#remove the department_tickets table 
  		drop_table :departments_tickets
  	end

end
