class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 10 }, presence: true

  scope :visible_to, lambda { |user| user ? scoped : where(public: true) }
end
