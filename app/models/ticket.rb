class Ticket < ActiveRecord::Base
	has_many :comments, -> {order created_at: :desc}
	has_many :products
	belongs_to :assignee, :class_name => "User",  :foreign_key => "reporter_id"
	belongs_to :reporter, :class_name => "User",  :foreign_key => "user_id"
	belongs_to :department
end
