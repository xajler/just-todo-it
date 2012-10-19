source 'https://rubygems.org'

gem 'rails'
gem 'bcrypt-ruby'
gem 'unicorn'
gem 'haml'
gem 'thin'
gem 'pg'

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'pry'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'awesome_print'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'spork'
  gem 'guard-spork'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
