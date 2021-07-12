# frozen_string_literal: true

# rubocop:disable Layout/HeredocIndentation(RuboCop)
def do_bundle
  # Custom bundle command ensures dependencies are correctly installed
  Bundler.with_unbundled_env { run 'bundle install' }
end

run 'bundle add grape'
run 'bundle add grape-entity'
run 'bundle add grape_logging'
run 'bundle add grape-swagger'
run 'bundle add grape-swagger-entity'
run 'bundle add grape-swagger-rails'

do_bundle

file 'app/api/base/api.rb', <<~CODE
# frozen_string_literal: true

class Base::API < Grape::API
  # @see https://github.com/aserafin/grape_logging
  require 'grape_logging'
  use GrapeLogging::Middleware::RequestLogger,
      logger: Rails.logger,
      include: [GrapeLogging::Loggers::FilterParameters.new,
                GrapeLogging::Loggers::ClientEnv.new]

  mount V1::Root
end

CODE

file 'app/api/v1/root.rb', <<~CODE
# frozen_string_literal: true

module V1
  class Root < Grape::API
    version :v1
    format :json
  end
end
CODE

run 'rm config/routes/api.rb'
file 'config/routes/api.rb', <<~CODE
# frozen_string_literal: true

Rails.application.routes.draw do
  mount Base::API => '/api'
  mount SwaggerUiEngine::Engine, at: '/docs'
end
CODE
# rubocop:enable Layout/HeredocIndentation(RuboCop)
