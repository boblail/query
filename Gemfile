source "https://rubygems.org"
ruby "2.1.2"

gem "rails", "4.2.0"

gem "pg"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"

# Use LESS for Bootstrap stylesheets
gem "less-rails"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.1.0"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem "therubyracer", platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"

# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use Unicorn as the app server
gem "unicorn-rails"

# Use Handlebars for front-end templates
gem "handlebars_assets"

# Use Omniauth for authentication
gem "octokit"
gem "omniauth"
gem "omniauth-github", github: "intridea/omniauth-github"
gem "cancan"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

gem "rack-mobile-detect", require: "rack/mobile-detect"

gem "xlsx", github: "concordia-publishing-house/xlsx", branch: "master"

group :production do
  gem "rails_12factor"
end

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug"
  gem "pry"

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"

  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem "spring"
end
