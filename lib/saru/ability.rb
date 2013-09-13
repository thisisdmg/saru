module Saru
  module Ability
    def can(actions, subjects, &block)
      rules.unshift(Rule.new(true, actions, subjects, &block))
    end

    def cannot(actions, subjects, &block)
      rules.unshift(Rule.new(false, actions, subjects, &block))
    end

    def can?(action, subject)
      match = rules.detect do |rule|
        if rule.relevant?(action, subject)
          rule.matches?(subject)
        end
      end

      match ? match.base_behavior : false
    end

    def cannot?(*args)
      !can?(*args)
    end

    def authorize!(action, subject, message = nil)
      if can?(action, subject)
        subject
      else
        raise AccessDenied.new(action, subject, message)
      end
    end

    private

    def rules
      @rules ||= []
    end
  end
end
