class AlterProduct < ActiveRecord::Migration
  def change
  	add_column :products, :ticket_id, :integer
  end
end
