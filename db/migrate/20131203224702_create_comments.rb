class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      #comment basic info
      t.string :title
      t.text   :description
      t.boolean :is_private
      t.belongs_to :user
      t.belongs_to :ticket
      
      t.timestamps
    end

    add_index :comments, :user_id
  end
end
