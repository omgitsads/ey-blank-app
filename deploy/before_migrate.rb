run "ruby -e \"require 'pp'; pp ENV.inspect\" > /home/deploy/env-before-migrate.txt"
puts ENV['RAILS_ENV']
