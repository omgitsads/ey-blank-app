app_name = 'eyblankapp'
error = <<-STR
if(\$content_type ~= "application\\/json") {
      rewrite ^(.*)$ \\/system\\/maintenance.json break;
    }

    rewrite ^(.*)$ \\/system\\/maintenance.html  break;
STR

if ['app', 'app_master', 'solo'].include?(node[:instance_role])
  service 'nginx' do
    supports :reload => true
    action :enable
  end

  execute "Add json maintenance" do
    command "sed -i 's/rewrite ^(.*)$ \\/system\\/maintenance.html break;/#{error.gsub("\n","\\n")}/' /etc/nginx/servers/#{app_name}.conf"
    notifies :restart, resources(:service => 'nginx')
    not_if "grep 'maintenance.json' /etc/nginx/servers/#{app_name}.conf"
  end
end
