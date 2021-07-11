# frozen_string_literal: true

# gem_group :development, :test do
  # gem 'rubocop', require: false
  # gem 'rubocop-performance', require: false
  # gem 'rubocop-rails', require: false
  # gem 'rubocop-rspec', require: false
# end

run 'bundle install'

gem_group :development, :test do
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

run 'bundle install'

rubocop_yml = <<-RUBOCOP
  require:
    - rubocop-performance
    - rubocop-rails
    - rubocop-rspec

  AllCops:
    DisplayStyleGuide: true
    StyleGuideBaseURL: https://github.com/fortissimo1997/ruby-style-guide/blob/japanese/README.ja.md
    Exclude:
      - 'db/migrate/*'
      - 'node_modules/**/*'
      - 'bin/*'
      - 'db/schema.rb'
      - 'vendor/bundle/**/*'
      - 'tmp/**/*'
      - 'lib/tasks/auto_annotate_models.rake'

  Metrics/BlockLength:
    Exclude:
      - 'config/routes.rb'
      - 'config/environments/*.rb'
      - 'spec/**/*.rb'
      - 'app/api/**/*'

  Metrics/ClassLength:
    Exclude:
      - 'app/api/**/*'
  MethodLength:
    CountComments: true
    Max: 11
  Layout/EmptyLinesAroundAttributeAccessor:
    Enabled: true

  Layout/SpaceAroundMethodCallOperator:
    Enabled: true

  Lint/DeprecatedOpenSSLConstant:
    Enabled: true

  Lint/DuplicateElsifCondition:
    Enabled: true

  Lint/MixedRegexpCaptureTypes:
    Enabled: true

  Lint/RaiseException:
    Enabled: true

  Lint/StructNewOverride:
    Enabled: true

  Style/AccessorGrouping:
    Enabled: true

  Style/ArrayCoercion:
    Enabled: true

  Style/BisectedAttrAccessor:
    Enabled: true

  Style/CaseLikeIf:
    Enabled: true

  Style/ExponentialNotation:
    Enabled: true

  Style/HashAsLastArrayItem:
    Enabled: true

  Style/HashEachMethods:
    Enabled: true

  Style/HashLikeCase:
    Enabled: true

  Style/HashTransformKeys:
    Enabled: true

  Style/HashTransformValues:
    Enabled: true

  Style/RedundantAssignment:
    Enabled: true

  Style/RedundantFetchBlock:
    Enabled: false

  Style/RedundantFileExtensionInRequire:
    Enabled: true

  Style/RedundantRegexpCharacterClass:
    Enabled: true

  Style/RedundantRegexpEscape:
    Enabled: true

  Style/SlicingWithRange:
    Enabled: true

  Style/AsciiComments:
    Enabled: false

  Style/ClassAndModuleChildren:
    Enabled: false

  Style/Documentation:
    Enabled: false

  Style/MethodCallWithArgsParentheses:
    Enabled: true
    IgnoredMethods:
      - 'exit'
      - 'mount'
      - 'puts'
      - 'require'
      - 'require_relative'
      - 'run'
      - 'to'
      - 'not_to'
    Exclude:
      - 'config/puma.rb'
      - 'Gemfile'

  Rails:
    Enabled: true

  Rails/ActiveRecordCallbacksOrder:
    Enabled: true

  Rails/FindById:
    Enabled: true

  Rails/Inquiry:
    Enabled: true

  Rails/MailerName:
    Enabled: true

  Rails/MatchRoute:
    Enabled: true

  Rails/NegateInclude:
    Enabled: true

  Rails/Pluck:
    Enabled: true

  Rails/PluckInWhere:
    Enabled: true

  Rails/RenderInline:
    Enabled: true

  Rails/RenderPlainText:
    Enabled: true

  Rails/ShortI18n:
    Enabled: true

  Rails/WhereExists:
    Enabled: true

  Rails/FindBy:
    Enabled: true

  Rails/FilePath:
    Enabled: false

  RSpec/ContextWording:
    Enabled: false

  RSpec/NestedGroups:
    Max: 5

  RSpec/MultipleExpectations:
    Max: 6

  Performance/AncestorsInclude:
    Enabled: true

  Performance/BigDecimalWithNumericArgument:
    Enabled: true

  Performance/RedundantSortBlock:
    Enabled: true

  Performance/RedundantStringChars:
    Enabled: true

  Performance/ReverseFirst:
    Enabled: true

  Performance/SortReverse:
    Enabled: true

  Performance/Squeeze:
    Enabled: true

  Performance/StringInclude:
    Enabled: true

RUBOCOP

create_file '.rubocop.yml', rubocop_yml
