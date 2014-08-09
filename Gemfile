source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.1.4'
gem 'dotenv-rails', :groups => [:development, :test]
gem 'pg'
gem 'jquery-rails'
gem 'selectivizr-rails'
gem 'respond-rails'
gem 'devise'
gem 'activeadmin', :github => 'gregbell/active_admin'
gem 'bourbon'
gem 'neat'
gem 'bitters'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'modernizr-rails'
gem 'normalize-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem 'omniauth-google-oauth2'
gem 'mini_magick'
gem 'carrierwave'
gem 'cloudinary'

group :production do
  gem "heroku_rails_deflate"
end

group :development do
  gem "foreman"
  gem "guard-bundler"
  gem "guard-rspec"
  gem "guard-spork"
  gem "rb-fsevent", require: false
end

group :development, :test do
  gem 'factory_girl_rails'
  gem "pry-rails"
  gem "pry-nav"
  gem "awesome_print"
  gem "quiet_assets"
  gem "rspec-rails"
end

group :test do
  gem "spork-rails"
  gem "database_cleaner"
  gem "shoulda-matchers"
  gem "capybara-webkit"
  gem "launchy"
  gem "fuubar"
  gem "simplecov"
end
