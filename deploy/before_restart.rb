f = File.open("/home/deploy/deploy-config.json","w+") do |f|
  f.write @configuration.to_json
end
