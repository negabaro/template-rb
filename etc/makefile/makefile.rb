# frozen_string_literal: true

# rubocop:disable Layout/HeredocIndentation(RuboCop)
file 'Makefile', <<-CODE
RAILS_CONTAINER_ID=`docker ps | grep rails | awk '{print $$1}'`

ENV_MODE="prd"
SERVICE="univas"
CONTAINER_NAME=${ENV_MODE}-${SERVICE}
IMG_NAME="rails"

ECR_HOST="xxx.dkr.ecr.ap-northeast-1.amazonaws.com"
STG_PRD_ECR_IMG_NAME="univas-rails-prd"
ECR_IMG_TAG="latest"
AWS_PROFILE="default"

define DOCKER_RUN
docker run \
	--rm --name $(CONTAINER_NAME) \
  -p 3000:3000 	$(IMG_NAME)/$(CONTAINER_NAME)
endef
export DOCKER_RUN

define DOCKER_BUILD
docker build -t ${IMG_NAME}/${CONTAINER_NAME} --file Dockerfile .
endef

define DOCKER_PUSH
#docker commit ${RAILS_CONTAINER_ID} ${IMG_NAME}/${CONTAINER_NAME}
docker tag ${IMG_NAME}/${CONTAINER_NAME} ${ECR_HOST}/${STG_PRD_ECR_IMG_NAME}:${ECR_IMG_TAG}
docker push ${ECR_HOST}/${STG_PRD_ECR_IMG_NAME}:${ECR_IMG_TAG}
endef

define DOCKER_RM_IF_CONTAINER_IS_ALIVE
if [ `docker ps -q -f name=${CONTAINER_NAME}` ]; then docker rm -f ${CONTAINER_NAME}; fi
endef

ecr-login:
	aws ecr get-login --no-include-email --region ap-northeast-1 --profile ${AWS_PROFILE} | sh -

push: ecr-login
	$(DOCKER_BUILD)
	$(DOCKER_PUSH)

# rails dockerイメージをbuildする
build:
	$(DOCKER_RM_IF_CONTAINER_IS_ALIVE)
	$(DOCKER_BUILD)

# rails dockerイメージをbuild & runする
build-run:
	$(DOCKER_RM_IF_CONTAINER_IS_ALIVE)
	$(DOCKER_BUILD)
	$(DOCKER_RUN)

# railsコンテナーログ確認(tail -f)
rails-log:
	docker logs $(RAILS_CONTAINER_ID) -f

# railsコンテナーに接続
exec-rails:
	docker exec -it $(RAILS_CONTAINER_ID) bash

bundle:
	bundle install --path vendor/bundle

migrate:
	bundle exec rake db:migrate

migrate_reset_db:
	DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:migrate:reset

seed:
	bundle exec rake db:seed --trace

seed_fu:
	bundle exec rake db:seed_fu

b:
	bundle exec bin/webpack
f:
	bundle exec foreman start -f Procfile.dev

s:
	bundle exec rails s

c:
	bundle exec rails c

w:
	bin/webpack-dev-server

r:
	bundle exec rspec
rr:
	bundle exec rake routes

reset_db:
	bundle exec rails db:drop
	bundle exec rails db:create
	bundle exec rails db:migrate
	bundle exec rails db:seed_fu
	bundle exec rails db:seed

build-mysql2:
	bundle config --local build.mysql2 "--with-cppflags=-I/usr/local/opt/openssl/include"
	bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib"
CODE

# rubocop:enable Layout/HeredocIndentation(RuboCop)
