class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :playlists
  before_create :set_member
  accepts_nested_attributes_for :posts
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, 
         :omniauthable, :omniauth_providers => [:facebook]

  #going to be the same for all Users
  SOUNDCLOUD_CLIENT_ID     = "1b53211793e50e91848a0abb56b0af30"
  SOUNDCLOUD_CLIENT_SECRET = "c7d8e92f66df1a97a12cd52b681f67a5"

  validates :name, length: { maximum: 15 }, presence: true

  def favorited(post)
    self.favorites.where(post_id: post.id).first
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      pass = Devise.friendly_token[0,20]
      user = User.new(name: auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         password: pass,
                         password_confirmation: pass
                        )
      user.skip_confirmation!
      user.save
    end
    user
  end

  def voted(post)
    self.votes.where(post_id: post.id).first
  end

  def self.top_rated
    self.select('users.*'). # Select all attributes of the user
        select('COUNT(DISTINCT comments.id) AS comments_count'). # Count the comments made by the user
        select('COUNT(DISTINCT posts.id) AS posts_count'). # Count the posts made by the user
        select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank'). # Add the comment count to the post count and label the sum as "rank"
        joins(:posts). # Ties the posts table to the users table, via the user_id
        joins(:comments). # Ties the comments table to the users table, via the user_id
        group('users.id'). # Instructs the database to group the results so that each user will be returned in a distinct row
        order('rank DESC') # Instructs the database to order the results in descending order, by the rank that we created in this query. (rank = comment count + post count)
  end

  ROLES = %w[member moderator admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def self.soundcloud_client(options={})
    options = {
      :client_id     => SOUNDCLOUD_CLIENT_ID,
      :client_secret => SOUNDCLOUD_CLIENT_SECRET,
    }.merge(options)

    Soundcloud.new(options)
  end

  private

  def set_member
    self.role = 'member'
  end
end
