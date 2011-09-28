f = File.open("/home/deploy/deploy-config.json","w+") do |f|
  f.write "User: #{user}"
  f.write "Application: #{app}"
  f.write @configuration.to_json
end
