# README

Suggested versions:

* Ruby: 3.3.0

* Rails: 7.1.2

* Bundler: 2.5.3

## System Requirements
- Install your preferred ruby version manager (rbenv, rvm). In this steps, we are going to use `rbenv`.

## Setting up the RoR environment
- Optinal: run `echo "gem: --no-document" >> ~/.gemrc` to avoid installing all the gems' docs.
- Go to your applications folder and install Ruby 3.3.0: `rbenv install 3.3.0`
- Run `rbenv local 3.3.0` (or another version of your choice)
- Install Rails: `gem install rails -v 7.1.2`
- Install bundler: `gem install bundler -v 2.5.3`


## Start with the repo
- Clone the repo.
- In your terminal, go to the repo folder and run `bundle install`
- Then run 
```
rails db:create
rails db:migrate
rails db:seed
```

If you're not using Windows and you're having issues with this gem, just remove it from the Gemfile list:
`gem 'tzinfo-data', platforms: %i[windows jruby]`

## For testing
- Run:
```
rails db:create RAILS_ENV=test
rails db:migrate RAILS_ENV=test
rspec
```