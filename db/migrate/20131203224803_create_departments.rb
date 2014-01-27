class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|

      t.string :department_name
      
      t.timestamps
    end

    create_join_table :tickets, :departments do |t|
    	t.index :ticket_id
    	t.index :department_id
    end
  end
end
