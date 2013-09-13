require 'rspec/expectations'

RSpec::Matchers.define :be_able_to do |action, subject|
  match do |ability|
    ability.can?(action, subject)
  end

  failure_message_for_should do |ability|
    "expected #{ability} to be able to #{action.inspect} #{subject.inspect}"
  end

  failure_message_for_should_not do |ability|
    "expected #{ability} not to be able to #{action.inspect} #{subject.inspect}"
  end
end
