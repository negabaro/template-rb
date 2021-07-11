# frozen_string_literal: true

gem_group :development, :test do
  gem 'rspec-rails'
end

run 'bundle install'
rails_command 'generate rspec:install'

run 'rm -rf test'
# run 'rm -rf test' if yes?('Do you want to remove the /test directory?')
