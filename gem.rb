# frozen_string_literal: true

# audit log
gem 'audited', '~> 4.9'

gem_group :development, :test do
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'ffaker'
end

after_bundle do
  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"
end
