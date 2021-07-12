# frozen_string_literal: true

def do_bundle
  # Custom bundle command ensures dependencies are correctly installed
  Bundler.with_unbundled_env { run 'bundle install' }
end

run 'bundle add devise'

do_bundle

rails_command 'generate devise:install'

# We don't use rails_command here to avoid accidentally having RAILS_ENV=development as an attribute
run 'rails generate devise User provider:string uid:string token:string meta:text refresh_token:string'
# rails_command('db:create')
rails_command('db:migrate')
