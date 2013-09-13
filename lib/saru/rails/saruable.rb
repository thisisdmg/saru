module Saru
  module Rails
    module Saruable
      extend ActiveSupport::Concern

      included do
        helper_method :current_ability, :can?, :cannot?
      end

      def current_ability
        @current_ability ||= ::Ability.new(current_user)
      end

      def can?(action, subject)
        current_ability.can?(action, subject)
      end

      def cannot?(action, subject)
        current_ability.cannot?(action, subject)
      end

      def authorize!(action, subject)
        current_ability.authorize!(action, subject)
      end
    end
  end
end

if defined?(ActionController::Base)
  ActionController::Base.class_eval do
    include Saru::Rails::Saruable
  end
end
