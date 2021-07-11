# frozen_string_literal: true

# rubocop:disable Layout/HeredocIndentation(RuboCop)
file 'app/controllers/front/members/registers_controller.rb', <<-CODE
# frozen_string_literal: true

class Front::Members::RegistersController < Devise::RegistrationsController

  def new
    @user = User.new()
  end

  def create
    super
  end
end
CODE

file 'app/controllers/front/members/sessions_controller.rb', <<-CODE
# frozen_string_literal: true

class Front::Members::SessionsController < Devise::SessionsController

  def new
  end

  # def create
  #   super
  # end

  def destroy
    super
  end
end
CODE
# rubocop:enable Layout/HeredocIndentation(RuboCop)
