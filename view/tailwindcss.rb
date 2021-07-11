# frozen_string_literal: true

def do_bundle
  Bundler.with_unbundled_env { run 'bundle install' }
end

gem_group :development do
  gem 'tailwindcss-rails'
end

do_bundle
run 'bin/rails tailwindcss:install'
# https://zenn.dev/fjsh/articles/2055416ca30cc4
