# frozen_string_literal: true

# rubocop:disable Layout/HeredocIndentation(RuboCop)
root = <<~ROUTES
# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren, Lint/RedundantCopDisableDirective
class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/\#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  draw :admin
  draw :debug
  draw :sidekiq
  draw :test
  draw :api
  draw :front
end
# rubocop:enable Style/ClassAndModuleChildren, Lint/RedundantCopDisableDirective

ROUTES
# rubocop:enable Layout/HeredocIndentation(RuboCop)

create_file 'config/routes.rb', root

# rubocop:disable Layout/HeredocIndentation(RuboCop)
sub_routes = <<-SUB_ROUTES
# frozen_string_literal: true
SUB_ROUTES
# rubocop:enable Layout/HeredocIndentation(RuboCop)

create_file 'config/routes/admin.rb', sub_routes
create_file 'config/routes/debug.rb', sub_routes
create_file 'config/routes/sidekiq.rb', sub_routes
create_file 'config/routes/test.rb', sub_routes
create_file 'config/routes/api.rb', sub_routes
create_file 'config/routes/front.rb', sub_routes
