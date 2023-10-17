class Abilities::Client
  include CanCan::Ability

  def initialize(user)
    can :show, User do |u|
      user.id == u.id
    end
    can :update, User, user_id: user.id
  end
end
