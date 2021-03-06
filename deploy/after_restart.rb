on_app_master do
  require 'rubygems'

  File.open("/home/deploy/deploy_env.json", "w") do |f|
    settings = {
      :env => ENV.to_hash,
      :gem_path => Gem.path,
      :gem_config => Gem.configuration.instance_eval { @hash }
    }
    f.write(settings.to_json)
  end
end
