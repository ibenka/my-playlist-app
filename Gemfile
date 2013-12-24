source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'sqlite3'
end

gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'

gem 'anjlab-bootstrap-rails', '~> 3.0.3.0', :require => 'bootstrap-rails'

gem 'newrelic_rpm' #User Authentication checkpoint Gemfile had this
gem 'jquery-rails'
gem 'faker'
gem 'devise'
gem 'cancan'

#already here (assuming from Rails 4)
gem 'turbolinks'
gem 'jbuilder', '~> 1.2' #already here
group :doc do
  gem 'sdoc', require: false
end
