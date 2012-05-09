run "ruby -e \"require 'pp'; pp ENV.inspect\" > /home/deploy/env-before-migrate.txt"

File.open("/home/deploy/rails_env.txt", "w") do |f|
  f.write "RAILS_ENV: #{ENV['RAILS_ENV']}"
end

raise
