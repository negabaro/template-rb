API_CONTAINER_ID=`docker ps | grep lullaby_api_app | awk '{print $$1}'`
DEV_APP_NAME=lullaby-api-development
STG_APP_NAME=lullaby-api-stg
PRD_APP_NAME=lullaby-api-prod

include .makerc

new1:
	rails new test1 -m 1.rb


current1:
	bin/rails app:template LOCATION=../1.rb
rubocop:
	bin/rails app:template LOCATION=../rubocop/rubocop.rb
rspec:
	bin/rails app:template LOCATION=../rspec/rspec.rb
factory-bot:
	bin/rails app:template LOCATION=../rspec/factory_bot_rails.rb