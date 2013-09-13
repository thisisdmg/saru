module Saru
  module Generators
    class AbilityGenerator < ::Rails::Generators::Base
      source_root File.join(__dir__, 'templates')

      desc 'This generator creates an example ability.rb file at app/models'
      def copy_ability_file
        copy_file 'ability.rb', 'app/models/ability.rb'
      end
    end
  end
end
