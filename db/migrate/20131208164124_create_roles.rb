class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
    	t.string  :name
    	t.timestamps

    end

    create_join_table :users, :roles do |t|
    	t.index :user_id 
    	t.index :role_id
    end
  end
end
