# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

require 'resque/server'
use Rack::ShowExceptions

RESQUE_WEB_PASSWORD = "testing123"
Resque::Server.use Rack::Auth::Basic do |username, password|
    password == RESQUE_WEB_PASSWORD
end

run Blank::Application
