source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

platforms :jruby do
  gem 'activerecord-jdbc-adapter', :require => false
  gem 'jdbc-postgres'
end

platforms :ruby do
  gem 'unicorn'
end

#gem 'pg'

gem 'json'
gem 'resque'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'ey_config'

# Use unicorn as the web server

#gem 'rails-backbone'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

