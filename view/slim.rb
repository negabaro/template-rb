# frozen_string_literal: true

def do_bundle
  Bundler.with_unbundled_env { run 'bundle install' }
end

# def do_commit
#   git :init
#   git add: '.'
#   git commit: " -m 'Switch to Slim templating' "
# end

say "\nApplying Slim templating..."
gem 'slim-rails', '~> 3.2'

gem_group :development do
  gem 'html2slim', '~> 0.2.0', require: false
end

do_bundle

# run 'erb2slim app/views -d'
# run 'git checkout app/views/layouts/application.html.erb'
# run 'rm app/views/layouts/application.html.slim'

# do_commit

# say "\nSwitched to Slim templating successfully!"
