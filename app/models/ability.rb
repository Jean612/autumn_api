# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Si el usuario no está autenticado, se crea un usuario ficticio

    can :index, User if user.admin?
    can :show, User do |u|
      user.id == u.id || user.admin?
    end
    can :update, User, user_id: user.id
    can :new, User

    # can :read, Post # Cualquier usuario puede leer posts
    # can :create, Post if user.persisted? # Solo usuarios autenticados pueden crear posts
    # can :update, Post, user_id: user.id # Solo el propietario del post puede actualizarlo
  end
end
