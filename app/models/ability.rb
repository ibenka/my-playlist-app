class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :member
        #can :manage, Post, user_id: user.id
        #can :manage, Comment, user_id: user.id

        #can :create, Post
        can :create, Comment
        can :comment, Comment
        #can :update, Post, user_id: user.id
        can :destroy, Comment, user_id: user.id
        can :destroy, Post, user_id: user.id
        can :create, Vote
        can :create, Favorite, user_id: user.id
        can :destroy, Favorite, user_id: user.id
        can :read, Topic

        can :create, Playlist
        can :update, Playlist, user_id: user.id
        can :destroy, Playlist, user_id: user.id
    end

    if user.role? :moderator
        can :create, Post
        can :update, Post, user_id: user.id
        can :update, Playlist
        can :destroy, Post
        can :destroy, Comment
        can :destroy, Playlist
    end

    if user.role? :admin
        can :manage, :all
    end

    can :read, Topic, public: true
    can :read, Post
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
