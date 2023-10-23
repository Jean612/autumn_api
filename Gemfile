source "https://rubygems.org"

ruby "3.2.2"

# Database
gem 'annotate', '~> 3.2', '>= 3.2.0'
gem 'pg',       '~> 1.4', '>= 1.4.6'

# Environment variables
gem 'figaro', '~> 1.2', '>= 1.2.0'

# GraphQL
gem 'batch-loader', '~> 2.0', '>= 2.0.1'
gem 'graphql',      '2.0.17.2'

# Internationalization
gem 'i18n-tasks', '~> 1.0', '>= 1.0.12'
gem 'rails-i18n', '~> 7.0', '>= 7.0.5'

# Math and financial
gem 'money-rails', '~> 1.15'

# Rails basic default gems
gem 'bootsnap', '~> 1.16', '>= 1.16.0', require: false
gem 'puma',     '~> 6.2',  '>= 6.2.1'
gem 'rails', '~> 7.1.0.rc2'

# Security and authentication
gem 'bcrypt',            '~> 3.1', '>= 3.1.18'
gem 'cancancan',         '~> 3.5', '>= 3.5.0'
gem 'jwt',               '~> 2.7', '>= 2.7.0'
gem 'rack-cors',         '~> 2.0', '>= 2.0.1'
gem 'strong_password',   '~> 0.0.9'
# Time
gem 'tzinfo-data', '~> 1.2023', '>= 1.2023.3', platforms: %i[mingw mswin x64_mingw jruby]

# Enviroment exclusive gems
group :development, :test do
  gem 'debug',                  '~> 1.7', '>= 1.7.2', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails',      '~> 6.2'
  gem 'faker',                  '~> 3.1', '>= 3.1.1'
  gem 'rspec',                  '~> 3.12'
  gem 'rspec_junit_formatter',  '~> 0.6.0'
  gem 'rspec-rails',            '~> 6.0',  '>= 6.0.1'
  gem 'rubocop',                '~> 1.51', '>= 1.51.0', require: false
  gem 'rubocop-graphql',        '~> 1.2',  '>= 1.2.0',  require: false
  gem 'rubocop-performance',    '~> 1.16', '>= 1.16.0', require: false
  gem 'rubocop-rails',          '~> 2.18', '>= 2.18.0', require: false
  gem 'rubocop-rspec',          '~> 2.19', '>= 2.19.0', require: false
  gem 'shoulda',                '~> 4.0.0'
  gem 'simplecov',              '~> 0.22.0', require: false
  gem 'webmock',                '~> 3.18', '>= 3.18.1'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.1'
end
