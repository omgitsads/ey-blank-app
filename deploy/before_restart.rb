extend EY::Serverside::LoggedOutput

Dir.chdir(release_path) do
  require "rubygems"
  require "bundler/setup"

  require "httparty"

  # You can also use post, put, delete, head, options in the same fashion
  response = HTTParty.get('http://twitter.com/statuses/public_timeline.json')
  [response.body, response.code, response.message, response.headers.inspect].each { |m| info(m.to_s) }
end
