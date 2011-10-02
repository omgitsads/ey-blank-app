on_app_master do
  File.open("/home/deploy/deploy_env.json", "w") do |f|
    f.write(ENV.to_json)
  end
end
