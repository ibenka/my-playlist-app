class Post < ActiveRecord::Base
	has_many :comments
  belongs_to :user
  belongs_to :topic
  accepts_nested_attributes_for :comments

  default_scope order('created_at DESC')
end
