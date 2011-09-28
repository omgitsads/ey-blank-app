f = File.open("~/deploy-config.json","w+") do |f|
  f.write @configuration.to_json
end
