# frozen_string_literal: true

# rubocop:disable Layout/HeredocIndentation(RuboCop)

def do_bundle
  # Custom bundle command ensures dependencies are correctly installed
  Bundler.with_unbundled_env { run 'bundle install' }
end

run 'bundle add omniauth'
run 'bundle add omniauth-google-oauth2'

do_bundle

file 'config/initializers/devise_omniauth.rb', <<-CODE
# frozen_string_literal: true

Devise.setup do |config|
  config.omniauth :google_oauth2,
                  ENV['GOOGLE_APP_ID'],
                  ENV['GOOGLE_APP_SECRET'],
                  skip_jwt: true,
                  name: :google,
                  scope: %w(email https://www.googleapis.com/auth/youtube.readonly)
end
CODE

file 'app/models/user.rb', <<-CODE
# frozen_string_literal: true

class User < ApplicationRecord

  devise :omniauthable, omniauth_providers: %i(google)

  #　devise :database_authenticatable, :registerable,
  #　:recoverable, :rememberable, :validatable,
  #　:omniauthable, omniauth_providers: %i[google]

  protected
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      refresh_token = auth.credentials.refresh_token
      user = User.create(email:         auth.info.email,
                         provider:      auth.provider,
                         uid:           auth.uid,
                         token:         auth.credentials.token,
                         refresh_token: refresh_token,
                         #　password: Devise.friendly_token[0, 20],
                         meta:     auth.to_yaml)
    end
    user
  end
end
CODE

# rubocop:enable Layout/HeredocIndentation(RuboCop)
