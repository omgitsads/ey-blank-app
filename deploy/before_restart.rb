Dir.chdir(release_path) do
  require File.expand_path(File.join(File.dirname(__FILE__), "deploy", "helpers"))

  make_gems_available

  require "httparty"

  # You can also use post, put, delete, head, options in the same fashion
  response = HTTParty.get('http://twitter.com/statuses/public_timeline.json')

  File.open("/home/deploy/deploy-config.json", "w") do |f|
    f.write response.inspect
  end
end

