# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Hopefully this is temporary, have PR open to the main repo: https://github.com/Shopify/job-iteration/pull/226
gem 'job-iteration', github: 'marksiemers/job-iteration', ref: 'fix-unknown-attribute-reference-error'

gemspec

gem "better_html"
gem "capybara"
gem "debug"
gem "mocha"
gem "puma"
if @rails_gem_requirement
  # causes Dependabot to ignore the next line and update the next gem "rails"
  rails = "rails"
  gem rails, @rails_gem_requirement
else
  gem "rails"
end
gem "rubocop"
gem "rubocop-shopify"
gem "selenium-webdriver"
gem "sprockets-rails"
if @sqlite3_requirement
  # causes Dependabot to ignore the next line and update the next gem "sqlite3"
  sqlite3 = "sqlite3"
  gem sqlite3, @sqlite3_requirement
else
  gem "sqlite3"
end
gem "yard"
