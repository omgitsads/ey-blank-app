Dir.chdir(release_path) do
  require "rubygems"
  require "bundler/setup"
  # Bundler.setup(:deploy)

  require "httparty"

  # You can also use post, put, delete, head, options in the same fashion
  response = HTTParty.get('http://twitter.com/statuses/public_timeline.json')
  # Do something with response
end

File.open("/home/deploy/deploy-config.json", "w") do |f|
  f.write("Deploying User: #{deploy_user}") if deploy_user
end
