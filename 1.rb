generate(:model, 'Post name:string')
generate(:model, 'User name:string')
rails_command('db:create')
rails_command('db:migrate')