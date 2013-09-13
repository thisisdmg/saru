require 'rspec/expectations'

RSpec::Matchers.define :be_able_to do |action, subject|
  match do |ability|
    ability.can?(action, subject)
  end
end

RSpec::Matchers.define :be_unable_to do |action, subject|
  match do |ability|
    ability.cannot?(action, subject)
  end
end
