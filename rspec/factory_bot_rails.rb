# frozen_string_literal: true

run 'spring stop'

gem_group :development, :test do
  gem 'factory_bot_rails'
  gem 'ffaker'
end

# rubocop:disable Layout/HeredocIndentation(RuboCop)
factory_bot = <<~FACTORY_BOT
# frozen_string_literal: true

RSpec.configure do |config|
  config.include(FactoryBot::Syntax::Methods)
end
FACTORY_BOT
# rubocop:enable Layout/HeredocIndentation(RuboCop)

create_file 'spec/support/factory_bot.rb', factory_bot

if yes?('Would you like to generate factories for your existing models?')
  Dir.glob(Rails.root.join('app/models/*.rb')).each { |file| require file }
  models = ApplicationRecord.send(:subclasses).map(&:name)

  models.each do |model|
    run("rails generate factory_bot:model #{model} #{model.constantize.columns.map { |column| "#{column.name}:#{column.type}" }.join(" ")}")
  end
end
