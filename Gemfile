source "https://rubygems.org"

ruby "3.3.0"

gem "rails", "~> 7.1.2"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", ">= 4.0.1"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem 'rspec-rails', '~> 6.1'
  gem 'rubocop', require: false
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "web-console"
end

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem "capybara"
  gem "selenium-webdriver"
end
