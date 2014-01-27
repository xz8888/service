class CreateRepairCodes < ActiveRecord::Migration
  def change
    create_table :repair_codes do |t|

      t.string :repair_codes
      t.string :repair_name
      
      t.timestamps
    end

    create_join_table :tickets, :repair_codes do |t|
    	t.index :ticket_id
    	t.index :repair_code_id
    end
  end
end
