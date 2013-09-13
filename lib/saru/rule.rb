module Saru
  class Rule
    attr_reader :base_behavior

    def initialize(base_behavior, actions, subjects, &block)
      @base_behavior = base_behavior
      @actions = [actions].flatten
      @subjects = [subjects].flatten
      @block = block
    end

    def relevant?(action, subject)
      action_relevant?(action) && subject_relevant?(subject)
    end

    def matches?(subject)
      if @block
        if @block.arity.zero?
          @block.call
        else
          @block.call(subject)
        end
      else
        true
      end
    end

    private

    def action_relevant?(action)
      (@actions.include?(action)) || (@actions.include?(:manage))
    end

    def subject_relevant?(subject)
      if @subjects.include?(:all)
        true
      else
        klass = subject.kind_of?(Class) ? subject : subject.class
        @subjects.any? { |subject| klass <= subject }
      end
    end
  end
end
