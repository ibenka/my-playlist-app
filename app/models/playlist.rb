class Playlist < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :topic

  validates :url, :url => true
  validates :user, presence: true
end
