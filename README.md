# Saru

[![Gem Version](https://badge.fury.io/rb/saru.png)](http://badge.fury.io/rb/saru)

Saru is an extraction of Ryan Bates' famous authorization library [CanCan](https://github.com/ryanb/cancan). As it is not _really_ maintained anymore, we decided to extract the crucial portions from it, fixing and improving them for our needs.

### Requirements
- Ruby >= 1.9.3

### Differences to CanCan
- Working Ability definition using Blocks
- No Hash conditions
- No Ability aliases
- No Tests

### Installation
Add this line to your application's Gemfile:
```ruby
gem 'saru', github: 'thisisdmg/saru'
```

And then execute:
```sh
$ bundle install
```
### Quick Start
```ruby
require 'saru'

class Ability
  include Saru::Ability

  def initialize(user)
    user ||= User.new

    can(:create, Article) if user.admin?
    can :read, Article
  end
end

admin = User.find(42)
user = User.find(815)

admin_ability = Ability.new(admin)
admin_ability.can?(:create, Article) # => true
admin_ability.can?(:read, Article)   # => true

user_ability = Ability.new(user)
user_ability.can?(:create, Article) # => false
user_ability.can?(:read, Article)   # => true
```

### Defining Abilies
```ruby
ability = Ability.new(user)

# without condition, always allowed.
ability.can :read, Article

# "outer" condition given, allowed if true.
ability.can(:create, Article) if user.admin?

# block condition given, allowed to update a single Article if block evaluates
# to true (== anything except false and nil).
ability.can(:update, Article) do |article|
  article.user_id == user.id
end

# block condition given, allowed to update all Articles if block evaluates
# to true (== anything except false and nil).
ability.can(:update, Article) do
  user.roles.where(name: 'editor').exists?
end

# special actions and subjects:
# :manage as action means having access to all actions on an Object,
# :all as subject means having access to any Object.
ability.can(:manage, :all) if user.allmighty?

# multi-action/multi-subject
can [:create, :read, :update, :destroy], Article
can :read, [Article, Comment]
can [:create, :read, :update, :destroy], [Article, Comment]

# Abilites are inherited using the class hierarchy.
Vehicle = Class.new
Car = Class.new(Vehicle)

ability.can :drive, Vehicle
ability.can? :drive, Vehicle # => true
ability.can? :drive, Car     # => true

# disallow access, later defined abilities have precedence.
# rules inside an ability are evaluated from the bottom to the top,
# stopping if there's a matching one.
ability.can :manage, Article
ability.cannot :destroy, Article

ability.can? :create, Article  # => true
ability.can? :destroy, Article # => false
```

### Rails 4
Add this line to your application's Gemfile:
```ruby
gem 'saru', github: 'thisisdmg/saru', require: 'saru/rails'
```

And then execute:
```sh
$ bundle install
```

#### Generate ability.rb in app/models
```sh
$ bin/rails generate saru:ability
```

#### Helper Methods
- `current_ability` (uses `current_user` per default)
- `can?(action, subject)`
- `cannot?(action, subject)`
- `authorize!(action, subject, message = nil)` (will raise `Saru::AccessDenied` if not authorized)

### License

Copyright (c) 2011 Ryan Bates

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
