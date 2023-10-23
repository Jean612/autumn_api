module Resolvers
  class UserDetails < Resolvers::Base
    type Types::UserType, null: true

    argument :id, ID, 'User id', required: false

    def self.authorized(_object, context)
      raise GraphQL::ExecutionError, I18n.t(:not_authorized_error) unless
        context[:current_user].present? && context[:current_ability]&.can?(:show, User)

      super
    end

    def resolve(id: nil)
      user = id ? User.active.find(id) : context[:current_user]
      raise GraphQL::ExecutionError, I18n.t(:not_authorized_error) unless context[:current_ability]&.can?(:show, user)

      user
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new(I18n.t('messages.errors.users.not_found'))
    end
  end
end
