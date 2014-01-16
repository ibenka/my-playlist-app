class Playlist < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :topic

  validates :url, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  default_scope order('updated_at DESC')

  def youtube_or_soundcloud(url)
    if url(0..1) == "//"
      true
    else
      false
    end
  end
end
