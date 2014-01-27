class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.string :style_name
      t.string :size
      t.string :color
      t.string :description
      t.integer :po_number
      
      t.timestamps
    end
  end
end
