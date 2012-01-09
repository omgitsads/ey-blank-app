if node[:quick]
  ey_cloud_report "Running quickrun shizzle!" do
    message 'Running quickrun shizzle!'
  end
else
  ey_cloud_report "Setting up quick-test in the main recipes" do
    message 'Setting up quck-test in main recipes'
  end

  link "/etc/chef/recipes/cookbooks/quick-test" do
    to "/etc/chef-custom/recipes/cookbooks/quick-test"
  end

  ruby_block do
    block do
      require 'erb'
      chef = File.read('/etc/chef/recipes/cookbooks/ey-base/recipes/default.rb')
      quickrun_block = chef.scan(/node\[:quick\]\n(.*)end\nelse/mx).flatten[0]
      recipes_block = quickrun_block.scan(/when .*\n([\s\w\S]*)/).flatten[0]
      recipes = recipes_block.scan(/require_recipe '(.*)'/)
      template = ERB.new File.read("/etc/chef/recipes/cookbooks/quick-test/templates/quickrun.erb")

      recipes << "quick-test"
      new_recipes_block = template.result binding

      new_chef = chef.gsub(recipes_block, new_recipes_block)

      File.open '/etc/chef/recipes/cookbooks/ey-base/recipes/default.rb', "w" do |f|
        f.write new_chef
      end
    end
    action :create
  end
end
