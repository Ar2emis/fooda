# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'haml-rails', '~> 2.0.1'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'
gem 'sass-rails', '>= 6'
gem 'sidekiq', '~> 6.2.0'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'lefthook', '~> 0.7.2'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 4.1.2'
  gem 'rubocop', '~> 1.11.0', require: false
  gem 'rubocop-performance', '~> 1.10.2', require: false
  gem 'rubocop-rails', '~> 2.9.1', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'ffaker', '~> 2.18.0'
  gem 'shoulda-matchers', '~> 4.5.1'
  gem 'simplecov', '~> 0.21.2'
end
