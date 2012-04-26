on_app_master do
  # Record the deploy in Airbrake!
  #info "cd #{current_path} && bundle exec rake airbrake:deploy TO=#{environment} REVISION=#{revision} USER=`whoami` REPO=#{repo}"

  # Notify New Relic of deploy
  info "cd #{release_path} && bundle exec newrelic_cmd deployments -e #{node[:environment][:framework_env]} -r #{`cat REVISION`}"
end

run "ruby -e \"require 'pp'; pp ENV\""
