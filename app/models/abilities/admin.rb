class Abilities::Admin
  include CanCan::Ability

  def initialize(user)
    can :index, User
    can :show, User do |u|
      user.admin?
    end
  end
end
