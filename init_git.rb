# frozen_string_literal: true

after_bundle do
  git :init
  git add: '.'
  git commit: %Q{ -m 'Initial commit' }
end
