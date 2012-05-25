if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  ey_cloud_report "passenger" do
    message "Building Passenger wrapper script"
  end

  service "nginx" do
    supports :restart => true
    action :enable
  end

  template "/home/deploy/passenger_wrapper.sh" do
    owner   node[:owner_name]
    group   node[:owner_name]
    mode    0755
    source  "passenger_wrapper.sh.erb"
    variables({:env_vars => {
      :TEST => 'testing'
    }})
  end

  execute "Add passenger_ruby to stack.conf" do
    command "echo 'passenger_ruby /home/deploy/passenger_wrapper.sh;' >> /etc/nginx/stack.conf"
    not_if "grep 'passenger_ruby' /etc/nginx/stack.conf"
    notifies :restart, resources(:service => 'nginx')
  end

end
