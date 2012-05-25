if [:app, :app_master, :solo].include?(node[:instance_role])
node[:applications].each do |app_name, app|
  execute "add utf8 encoding for #{app_name}" do
    command "sed -i '/reconnect: true/ a\\  encoding: utf8' /data/#{app_name}/shared/config/database.yml"
    action :run

    not_if "grep 'encoding:' /data/#{app_name}/shared/config/database.yml"
  end
end
end
